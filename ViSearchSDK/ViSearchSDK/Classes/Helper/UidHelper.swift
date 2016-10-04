import Foundation

public class UidHelper: NSObject {
    static let ViSearchUidKey = "visearch_uid"
    
    // generate unique device uid
    public static func uniqueDeviceUid() -> String {
        let storeUid = SettingHelper.getStringSettingProp(propName: ViSearchUidKey)
        
        if storeUid == nil || storeUid?.characters.count == 0 {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString ;
            
            // store in the setting
            SettingHelper.setSettingProp(propName: ViSearchUidKey, newValue: deviceId!)
            
            return deviceId!
        }
        
        return storeUid!
    }
    
    public static func updateStoreDeviceUid(newUid: String) -> Void {
        SettingHelper.setSettingProp(propName: ViSearchUidKey, newValue: newUid)
    }
}
