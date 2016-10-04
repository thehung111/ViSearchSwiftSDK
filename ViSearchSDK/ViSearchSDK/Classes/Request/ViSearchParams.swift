import Foundation

public class ViSearchParams: ViBaseSearchParams {
    var imName: String
    
    public init(imName: String){
        self.imName = imName
    }
    
    public override func toDict() -> [String: Any] {
        var dict = super.toDict()
        dict["im_name"] = imName
        return dict;
    }
}
