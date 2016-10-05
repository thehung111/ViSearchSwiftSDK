import Foundation

public class ViTrackParams : ViSearchParamsProtocol{

    public var action : String
    public var imName : String?
    public var reqId  : String
    public var cuid   : String?
    var cid    : String
    
    public init?(accessKey: String, reqId : String , action: String ) {
        
        if accessKey.isEmpty {
            return nil
        }
        
        if reqId.isEmpty {
            return nil
        }
        
        if action.isEmpty {
            return nil
        }
        
        self.cid = accessKey
        self.reqId = reqId
        self.action = action
        self.cuid = nil
        self.imName = nil
    }
    
    public func toDict() -> [String: Any] {
        var dict : [String:Any] = [:]
        dict["action"] = action
        dict["reqid"] = reqId
        dict["cid"] = cid
        
        if imName != nil {
            dict["im_name"] = imName
        }
        if cuid != nil {
            dict["cuid"] = cuid
        }
        return dict ;
        
    }
    
}
