import Foundation

// wrapper for various API calls
// create shared client
open class ViSearch: NSObject {
    
    public static let sharedInstance = ViSearch()
    
    public var client : ViSearchClient?
    
    private override init(){
        super.init()
    }
    
    // MARK: setup
    public func setup(accessKey: String, secret: String) -> Void {
        if client == nil {
            client = ViSearchClient(accessKey: accessKey, secret: secret)
        }
        
        client?.accessKey = accessKey
        client?.secret = secret
    }
    
    // MARK: API calls
    @discardableResult public func uploadSearch(params: ViUploadSearchParams,
                                                successHandler: @escaping ViSearchClient.SuccessHandler,
                                                failureHandler: @escaping ViSearchClient.FailureHandler) -> URLSessionTask?
    {
        if let client = client {
            return client.uploadSearch(params: params, successHandler: successHandler, failureHandler: failureHandler);
        }
        
        print("\(type(of: self)).\(#function)[line:\(#line)] - error: client is not initialized. Please call setup(accessKey, secret) before using the API.")
        return nil
    }
    
    @discardableResult public func colorSearch(params: ViColorSearchParams,
                                               successHandler: @escaping ViSearchClient.SuccessHandler,
                                               failureHandler: @escaping ViSearchClient.FailureHandler
        ) -> URLSessionTask?
    {
        if let client = client {
            client.colorSearch(params: params, successHandler: successHandler, failureHandler: failureHandler)
        }
        
        print("\(type(of: self)).\(#function)[line:\(#line)] - error: client is not initialized. Please call setup(accessKey, secret) before using the API.")
        return nil
    }
    
    @discardableResult public func findSimilar(params: ViSearchParams,
                                               successHandler: @escaping ViSearchClient.SuccessHandler,
                                               failureHandler: @escaping ViSearchClient.FailureHandler
        ) -> URLSessionTask?
    {
        if let client = client {
            client.findSimilar(params: params, successHandler: successHandler, failureHandler: failureHandler)
        }
        
        print("\(type(of: self)).\(#function)[line:\(#line)] - error: client is not initialized. Please call setup(accessKey, secret) before using the API.")
        return nil
    }
    
    @discardableResult public func recommendation(params: ViSearchParams,
                                                  successHandler: @escaping ViSearchClient.SuccessHandler,
                                                  failureHandler: @escaping ViSearchClient.FailureHandler
        ) -> URLSessionTask?
    {
        if let client = client {
            client.recommendation(params: params, successHandler: successHandler, failureHandler: failureHandler)
        }
        
        print("\(type(of: self)).\(#function)[line:\(#line)] - error: client is not initialized. Please call setup(accessKey, secret) before using the API.")
        return nil
    }
    
    // track the API calls and various actions
    @discardableResult public func track(params: ViTrackParams,
                                         handler:  ( (_ success: Bool, Error?) -> Void )?
        ) -> Void {
        
        if let client = client {
            client.track(params: params, handler: handler)
            return
        }
        
        print("\(type(of: self)).\(#function)[line:\(#line)] - error: client is not initialized. Please call setup(accessKey, secret) before using the API.")
        
    }
    

}
