import Foundation

public protocol ViSearchParamsProtocol{
    func toDict() -> [String: Any]
    //- (NSData*)httpPostBodyWithObject:(id)object;

}

public class ViBaseSearchParams : ViSearchParamsProtocol {

    // MARK properties
    public var limit : Int = 10
    public var page  : Int = 1
    public var score : Bool = false
    public var fq    : [String:String] = [:]
    public var fl    : [String] = []
    public var queryInfo : Bool = false
    public var scoreMin : Float = 0
    public var scoreMax : Float = 1
    public var getAllFl : Bool = false
    public var detection : String? = nil
    
    // MARK search protocol
    public func toDict() -> [String: Any] {
        var dict : [String:Any] = [:]
        
        if limit > 0 {
            dict["limit"] = String(limit)
        }
        
        if page > 0 {
            dict["page"] = String(page)
        }
      
        dict["score"] = score ? "true" : "false"
        
        dict["score_max"] = String(format: "%f", scoreMax);
        dict["score_min"] = String(format: "%f", scoreMin);
        
        dict["get_all_fl"] = (getAllFl ? "true" : "false" )
        
        if (detection != nil) {
            dict["detection"] = detection!
        }
        
        if queryInfo {
            dict["qinfo"] = "true"
        }
        
        if fq.count > 0 {
            var arr : [String] = []
            for ( key, val) in fq {
                let s = "\(key):\(val)"
                arr.append(s)
            }
            
            dict["fq"] = arr
        }
        
        if fl.count > 0 {
            dict["fl"] = fl
        }
        
        return dict ;
        
    }
    
}
