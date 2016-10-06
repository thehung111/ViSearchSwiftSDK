//
//  ViewController.swift
//  Example
//
//  Created by Hung on 4/10/16.
//  Copyright © 2016 ViSenze. All rights reserved.
//

import UIKit
import ViSearchSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        ViSearch.sharedInstance.setup(accessKey: "YOUR_ACCESS_KEY", secret: "YOUR_SECRET")
        
    }
    
    private func sampleUploadSearchByImage(){
        let image = UIImage(named: "someImage.png")
        let params = ViUploadSearchParams(image: image!)
        
        ViSearch.sharedInstance.uploadSearch( params: params,
                            successHandler: {
                                (data : ViResponseData?) -> Void in
                                // Do something when request succeeds
                                // preview by calling : dump(data)
                                // check ViResponseData.hasError and ViResponseData.error for any errors return by ViSenze server
                            },
                            failureHandler: {
                                (err) -> Void in
                                // Do something when request fails e.g. due to network error
                                print ("error: \(err.localizedDescription)")
        })
    }
    
    private func sampleUploadSearchByURL(){
        let params = ViUploadSearchParams(im_url: "http://somesite.com/sample_image.png")
        
        let box = ViBox(x1: 5, y1: 5, x2: 5, y2: 5)
        params?.box = box
        params?.img_settings = ViImageSettings(size: CGSize(width: 800, height: 800), quality: 0.9)
        
        ViSearch.sharedInstance.uploadSearch( params: params!,
                             successHandler: {
                                (data : ViResponseData?) -> Void in
                                // Do something when request succeeds
                                // preview by calling : dump(data)
                                // check ViResponseData.hasError and ViResponseData.error for any errors return by ViSenze server
                                
                                if let data = data {
                                    // check if that there is no error
                                    if !data.hasError {
                                        for imgResult in data.result {
                                            // process img result
//                                            print imgResult.metadataDict["price"]
                                        }
                                    }
                                }
            },
                             failureHandler: {
                                (err) -> Void in
                                // Do something when request fails e.g. due to network error
                                print ("error: \(err.localizedDescription)")
        })
    }

    private func sampleUploadSearchByImgId(){
        let params = ViUploadSearchParams(im_id: "im_id_example")
        
        ViSearch.sharedInstance.uploadSearch( params: params!,
                                              successHandler: {
                                                (data : ViResponseData?) -> Void in
                                                // Do something when request succeeds
                                                // preview by calling : dump(data)
                                                // check ViResponseData.hasError and ViResponseData.error for any errors return by ViSenze server
            },
                                              failureHandler: {
                                                (err) -> Void in
                                                // Do something when request fails e.g. due to network error
                                                print ("error: \(err.localizedDescription)")
        })
    }

    
    private func sampleFindSimilar(){
        let params = ViSearchParams(imName: "imName-example")
        
        ViSearch.sharedInstance.findSimilar( params: params!,
                            successHandler: {
                                (data : ViResponseData?) -> Void in
                                    // Do something when request succeeds
                                    // preview by calling : dump(data)
                                    // check ViResponseData.hasError and ViResponseData.error for any errors return by ViSenze server
                            },
                           failureHandler: {
                                (err) -> Void in
                                // Do something when request fails e.g. due to network error
                                print ("error: \(err.localizedDescription)")
                            })
    }
    
    private func sampleRecommend(){
        let params = ViSearchParams(imName: "imName-example")
        ViSearch.sharedInstance.recommendation( params: params!,
                            successHandler: {
                                (data : ViResponseData?) -> Void in
                                // Do something when request succeeds
                                // preview by calling : dump(data)
                                // check ViResponseData.hasError and ViResponseData.error for any errors return by ViSenze server
                            },
                            failureHandler: {
                                (err) -> Void in
                                // Do something when request fails e.g. due to network error
                                print ("error: \(err.localizedDescription)")
        })
    }
    
    private func sampleColorSearch(){
        let params = ViColorSearchParams(color: "ff00ff")
        ViSearch.sharedInstance.colorSearch( params: params!,
                               successHandler: {
                                (data : ViResponseData?) -> Void in
                                // Do something when request succeeds
                                // preview by calling : dump(data)
                                // check ViResponseData.hasError and ViResponseData.error for any errors return by ViSenze server
                                },
                               failureHandler: {
                                (err) -> Void in
                                // Do something when request fails e.g. due to network error
                                print ("error: \(err.localizedDescription)")
        })
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

