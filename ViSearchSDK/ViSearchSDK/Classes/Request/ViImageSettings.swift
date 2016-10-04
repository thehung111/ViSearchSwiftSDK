import Foundation

public class ViImageSettings {
    public enum Options {case defaultSetting, highQualitySetting}
    
    public var quality: Float
    public var maxWidth: Float
    
    public init(setting: Options){
        // high quality
        if(setting == .highQualitySetting){
            quality = 0.985;
            maxWidth = 1024;
        }
        
        // default setting
        quality = 0.97;
        maxWidth = 512;
    }
    
    public init(size: CGSize, quality: Float) {
        self.quality = quality
        self.maxWidth = Float( (size.height > size.width) ? size.height : size.width);
    }

}
