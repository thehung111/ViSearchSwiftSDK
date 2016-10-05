import Foundation

// image result in the "result" section of the response
open class ViImageResult: NSObject {
    // MARK: properties
    public var im_name: String
    
    // store the image url, in the value_map, may be unavailable
    public var im_url : String?
    
    // store the score if "score" is set to true in the request
    public var score  : Float?
    
    // store the meta data in the value_map
    public var metadataDict: [String: Any]?
    
    public init?(_ im_name: String) {
        if im_name.isEmpty{
            return nil
        }
        
        self.im_name = im_name
    }
    
}
