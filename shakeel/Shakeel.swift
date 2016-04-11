//
//  API.swift
//  shakeel
//
//  Created by Tejen Hasmukh Patel on 4/11/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Shakeel: NSObject {
    
    class func api(parameters: NSDictionary, endpoint: String, completion: ((NSDictionary?) -> ())?){
        let url: NSURL = NSURL(string: "https://api.sfrepairguy.com/" + endpoint)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        request.addValue("tejen", forHTTPHeaderField: "X-Auth-Token")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(parameters, options: []);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("API Network Error Occurred")
                return
            }
            
            // print out raw http response body
            //    print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            do {
                let dataObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                if(dataObject?.valueForKey("error") != nil) {
                    print("/#/#/#/#/#/#/#/#/#/#/");
                    print(" API ERROR OCCURRED:");
                    print(dataObject!["error"]!);
                    print("\n");
                    print("/#/#/#/#/#/#/#/#/#/#/");
                }
                if(completion != nil) {
                    completion!(dataObject);
                }
            } catch(_) {
                print("API Internal Server Error Occurred");
            }
            
        }
        
        task.resume()
    }
    
}
