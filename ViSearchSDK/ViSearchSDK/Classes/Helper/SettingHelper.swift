import Foundation

// store settings
public class SettingHelper {
    public static func setSettingProp(propName: String , newValue: Any?) -> Void {
        let userDefault = UserDefaults.standard
        userDefault.set(newValue, forKey: propName)
        // this will be deprecated in future
//        userDefault.synchronize()
    }
    
    public static func getStringSettingProp (propName: String) -> String? {
        let userDefault = UserDefaults.standard
        return userDefault.string(forKey: propName)
    }
}
