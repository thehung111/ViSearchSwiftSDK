import Foundation

public class ViTrackParams: ViBaseSearchParams {

    var action : String
    var imName : String?
    var reqId  : String
    var cuid   : String?
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
