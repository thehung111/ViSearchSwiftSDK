import Foundation

public enum ViHttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum ViAPIEndPoints: String {
    case COLOR_SEARCH  = "colorsearch"
    case ID_SEARCH     = "search"
    case UPLOAD_SEARCH = "uploadsearch"
    case REC_SEARCH    = "recommendation"
    case TRACK         = "__aq.gif"
}


open class ViSearchClient: NSObject, URLSessionDelegate {
    
    public static let VISENZE_URL = "https://visearch.visenze.com"
    
    public typealias SuccessHandler = (ViResponseData?) -> ()
    public typealias FailureHandler = (Error) -> ()
    
    // MARK: properties
    public var accessKey : String
    public var secret    : String
    public var baseUrl   : String
    
    public var session: URLSession
    public var sessionConfig: URLSessionConfiguration
//    private var uploadSession: URLSession?

    public var timeoutInterval : TimeInterval = 10 // how long to timeout request
    public var requestSerialization: ViRequestSerialization
    
 
    // MARK: constructors
    public init?(baseUrl: String, accessKey: String , secret: String) {
        
        if baseUrl.isEmpty {
            return nil;
        }
        
        if accessKey.isEmpty {
            return nil;
        }
        
        if secret.isEmpty {
            return nil;
        }
        
        self.baseUrl = baseUrl
        self.accessKey = accessKey
        self.secret = secret
        
        self.requestSerialization = ViRequestSerialization()
        
        // config default session
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = true
        sessionConfig.timeoutIntervalForRequest = timeoutInterval
        sessionConfig.timeoutIntervalForResource = timeoutInterval
        
        // Configuring caching behavior for the default session
        let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cachesDirectoryURL.appendingPathComponent("viSearchCache")
        let diskPath = cacheURL.path
        
        let cache = URLCache(memoryCapacity:16384, diskCapacity: 268435456, diskPath: diskPath)
        sessionConfig.urlCache = cache
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        
        // base 64 authentication
        sessionConfig.httpAdditionalHeaders = ["Authorization" : requestSerialization.getBasicAuthenticationString(accessKey: accessKey, secret: secret)]
        
        session = URLSession(configuration: sessionConfig)
        
        
    }
    
    public convenience init?(accessKey: String , secret: String)
    {
        self.init( baseUrl: ViSearchClient.VISENZE_URL , accessKey: accessKey, secret: secret)
    }
    
    // MARK: Visenze APIs
    public func colorSearch(params: ViColorSearchParams,
                            successHandler: @escaping SuccessHandler,
                            failureHandler: @escaping FailureHandler
                            ) -> URLSessionTask
    {
        return makeGetApiRequest(params: params, apiEndPoint: .COLOR_SEARCH, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    public func findSimilar(params: ViSearchParams,
                            successHandler: @escaping SuccessHandler,
                            failureHandler: @escaping FailureHandler
        ) -> URLSessionTask
    {
        return makeGetApiRequest(params: params, apiEndPoint: .ID_SEARCH, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    public func recommendation(params: ViSearchParams,
                            successHandler: @escaping SuccessHandler,
                            failureHandler: @escaping FailureHandler
        ) -> URLSessionTask
    {
        return makeGetApiRequest(params: params, apiEndPoint: .REC_SEARCH, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    // track the API calls and various actions
    public func track(params: ViTrackParams,
                      handler:  ( (_ success: Bool, Error?) -> Void )?
                      ) -> Void {
        
        // different url for tracking
        let url = requestSerialization.generateRequestUrl(baseUrl: "https://track.visenze.com" , apiEndPoint: .TRACK , searchParams: params)
        var request = URLRequest(url: URL(string: url)! , cachePolicy: .useProtocolCachePolicy , timeoutInterval: timeoutInterval)
        
        let deviceUid = UidHelper.uniqueDeviceUid()
        request.addValue("uid=\(deviceUid)", forHTTPHeaderField: "Cookie")
        
        session.dataTask(with: request, completionHandler:{
            (data, response, error) in
            if handler != nil {
                let hasError = (error == nil)
                handler!( hasError ,  error )
            }
        }).resume()
    }
    
    // MARK: http requests internal
    private func makeGetApiRequest(params: ViBaseSearchParams,
                                   apiEndPoint: ViAPIEndPoints,
                                   successHandler: @escaping SuccessHandler,
                                   failureHandler: @escaping FailureHandler
        ) -> URLSessionTask{
        
        let url = requestSerialization.generateRequestUrl(baseUrl: baseUrl, apiEndPoint: apiEndPoint , searchParams: params)
        let request = URLRequest(url: URL(string: url)! , cachePolicy: .useProtocolCachePolicy , timeoutInterval: timeoutInterval)
        
        // make tracking call to record the action 
        return httpGet(request: request,
                       successHandler: {
                             (data: ViResponseData?) -> Void in
                        
                               if let resData = data {
                                  if let reqId = resData.reqId {
                                    let params = ViTrackParams(accessKey: self.accessKey, reqId: reqId, action: apiEndPoint.rawValue )
                                    self.track(params: params!, handler: nil)
                                  }
                               }
                        
                               successHandler(data)
                       },
                       failureHandler: failureHandler )
        
    }
    
    private func httpGet(request: URLRequest,
                         successHandler: @escaping SuccessHandler,
                         failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        return httpRequest(method: ViHttpMethod.GET, request: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    private func httpPost(request: URLRequest,
                         successHandler: @escaping SuccessHandler,
                         failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        return httpRequest(method: ViHttpMethod.POST, request: request, successHandler: successHandler, failureHandler: failureHandler)
    }
    
    private func httpRequest(method: ViHttpMethod,
                             request: URLRequest,
                             successHandler: @escaping SuccessHandler,
                             failureHandler: @escaping FailureHandler) -> URLSessionTask {
        
        
        let task = createSessionTaskWithRequest(request: request, successHandler: successHandler, failureHandler: failureHandler)
        task.resume()
        
        return task
    }
    
    /**
     *  create data task session for request
     *
     *  @param URLRequest   request
     *  @param SuccessHandler success handler closure
     *  @param FailureHandler failure handler closure
     *
     *  @return session task
     */
    private func createSessionTaskWithRequest(request: URLRequest,
                                              successHandler: @escaping SuccessHandler,
                                              failureHandler: @escaping FailureHandler) -> URLSessionTask
    {
        let task = session.dataTask(with: request , completionHandler:{
            (data, response, error) in
            if (error != nil) {
                failureHandler(error!)
            }
            else {
                if response == nil || data == nil {
                    successHandler(nil)
                }
                else{
                    let responseData = ViResponseData(response: response!, data: data!)
                    successHandler(responseData)
                }
            }
        })
        
        return task
    }
    
    
}
