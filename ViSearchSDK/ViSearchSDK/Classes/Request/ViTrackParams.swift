import Foundation

public class ViTrackParams: ViBaseSearchParams {

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
    
}
