//
//  ViResponseData.swift
//  ViSearchSDK
//
//  Created by Hung on 4/10/16.
//  Copyright © 2016 Hung. All rights reserved.
//

import Foundation

open class ViResponseData: NSObject {
    var urlResponse : URLResponse
    var data: Data
    
    init(response: URLResponse, data: Data) {
        self.urlResponse = response
        self.data = data
    }

}
