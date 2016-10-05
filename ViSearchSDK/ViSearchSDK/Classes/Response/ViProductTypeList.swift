import Foundation

open class ViProductTypeList: NSObject {
    public var type  : String
    public var attributes_list : [String: Any] = [:]
    
    public init(type: String) {
        self.type = type
    }
}
