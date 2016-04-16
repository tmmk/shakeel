//
//  API.swift
//  shakeel
//
//  Created by Tejen Hasmukh Patel on 4/11/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Shakeel: NSObject {
    
    static var UUID: String {
        var uuid = Keychain.get("Shakeel_UUID") as? String;
        if(uuid == nil) {
            uuid = NSUUID().UUIDString;
            Keychain.set("Shakeel_UUID", value: uuid!);
        }
        return uuid!;
    }
    
    class func api(parameters: NSDictionary, endpoint: String, completion: ((NSDictionary?) -> ())?){
        let url: NSURL = NSURL(string: "https://api.sfrepairguy.com/" + endpoint)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        request.addValue(Shakeel.UUID, forHTTPHeaderField: "X-Auth-Token")
        
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
            
            do {
                let dataObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                if(dataObject?.valueForKey("error") != nil) {
                    print("/#/#/#/#/#/#/#/#/#/#/");
                    print(" API ERROR OCCURRED:\n");
                    print(dataObject!["error"]!);
                    print("\n");
                    print("/#/#/#/#/#/#/#/#/#/#/");
                    
                    alert("Uh oh!", message: dataObject!["error"]! as! String, button: "Try Again");
                }
                if(completion != nil) {
                    completion!(dataObject);
                }
            } catch(_) {
                print("API Internal Server Error Occurred:");
                // print out raw http response body
                print(NSString(data: data!, encoding: NSUTF8StringEncoding));
            }
            
        }
        
        task.resume()
    }
    
}
