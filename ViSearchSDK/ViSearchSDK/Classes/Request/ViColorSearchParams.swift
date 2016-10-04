//
//  ViColorSearchParams.swift
//  ViSearchSDK
//
//  Created by Hung on 3/10/16.
//  Copyright © 2016 Hung. All rights reserved.
//

import Foundation

public class ViColorSearchParams: ViBaseSearchParams {
    var color: String
    
    public init? ( color: String ) {
        self.color = color
        
        //verify that color is exactly 6 digits
        if self.color.characters.count != 6 {
            return nil
        }
        
        // verify color is of valid format i.e. only a-fA-F0-9
        let regex = try! NSRegularExpression(pattern: "[^a-fA-F|0-9]", options: [])
        let numOfMatches = regex.numberOfMatches(in: self.color, options: [.reportCompletion], range: NSMakeRange(0, self.color.characters.count ))
        if numOfMatches != 0 {
            return nil
        }
    }
    
    public override func toDict() -> [String: Any] {
        var dict = super.toDict()
        dict["color"] = color
        return dict;
    }
    
}
