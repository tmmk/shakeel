//
//  User.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

// usage:
//  creating a new user: User.create(username: "", password: "", display_name: "")
//  modifying a user: existinguser.update("profile_image_url", "");
//  getting a user by ID: User.getUserByIDWithCompletion(id: "", completion: (user: User?) -> () in { print(user) });
//  getting a user by username: User.getUserByUsernameWithCompletion(username: "", completion: (user: User?) -> () in { print(user) });

class User: NSObject {
    var id: String? {
        didSet {
            if(id != nil && id != "") {
                reloadUserDevices();
            }
        }
    }
    var username: String?
    var password: String?
    var display_name: String?
    var profile_image_url: String?
    
    var devices: [Device]?
    
    func reloadUserDevices() {
        User.api("UserId=\(id)", endpoint: "/devices/get/") { (response: AnyObject?) -> () in
            let responseDictionary = response as! [NSDictionary];
            var devices: [Device]?;
            for device in responseDictionary {
                devices?.append(Device(dictionary: device)!);
            }
            self.devices = devices;
        }
    }
    
    func update(key: String, value: String) {
        User.api("id=\(id),\(key)=\(value)", endpoint: "/users/modify/", completion: nil);
    }
    
    class func create(username: String, password: String, display_name: String) {
        let user = User();
        user.username = username;
        user.password = password;
        user.display_name = display_name;
        User.api("username=\(username),password=\(password),display_name=\(display_name)", endpoint: "/users/create/") { (response: AnyObject?) -> () in
            let responseDictionary = response as! NSDictionary;
            user.id = responseDictionary["id"] as! String;
        }
    }
    
    class func instantiateWithDictionary(dictionary: NSDictionary?) -> User? {
        if(dictionary == nil) {
            return nil
        }
        let user = User();
        user.id = dictionary!["id"] as? String;
        user.username = dictionary!["username"] as? String;
        user.password = dictionary!["password"] as? String;
        user.display_name = dictionary!["display_name"] as? String;
        user.profile_image_url = dictionary!["profile_image_url"] as? String;
        return user;
    }

    class func getUserByIDWithCompletion(id: String, completion: ((User?) -> ())?) {
        User.api("id=\(id)", endpoint: "/users/get/", completion: completion)
    }
    
    class func getUserByUsernameWithCompletion(username: String, completion: ((User?) -> ())?) {
        User.api("username=\(username)", endpoint: "/users/get/", completion: completion)
    }
    
    class func api(query: String, endpoint: String, completion: ((User?) -> ())?){
        let url: NSURL = NSURL(string: "https://www.sfrepairguy.com/api" + endpoint)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = query
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("api network error")
                return
            }
            
            do {
                let dataObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments);
                if(completion != nil) {
                    completion!(User.instantiateWithDictionary(dataObject as? NSDictionary));
                }
            } catch(_) {
                
            }
            
        }
        
        task.resume()
    }
}
