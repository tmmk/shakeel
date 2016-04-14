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
//  getting a user by ID: User.get({ (user: User?) in print(user); }, id: 123);
//  getting a user by username: User.get({ (user: User?) in print(user); }, username: "shakeel156");

class User: Shakeel {
    
    // Hold currently logged-in user and protect write-access from other classes.
    static private var _currentUser: User? = nil; // No other class besides User can modify this private variable
    static var currentUser: User? { // return read-only variable to a global scope
        return _currentUser;
    }
    
    var id: Int? {
        didSet {
            if(id != nil && id != 0) {
                populateDevices();
            }
        }
    }
    var username: String?
    private var password: String? // Never contains cleartext password. Only the User class can access this private variable... but passwordDoesMatch() is global :)
    var display_name: String?
    var profile_image_url: String?
    
    var devices: [Device]?

    class func create(username: String, password: String, display_name: String) {
        let user = User();
        user.username = username;
        user.password = password.sha1();
        user.display_name = display_name;
        
        user.api(["username": username, "password": password, "display_name": display_name], endpoint: "users/create/") { (response: User?) -> () in
            user.id = response!.id;
        }
    }
    
    // completion parameter first, else Swift won't allow function overloading
    class func get(completion: ((User?) -> ()), id: Int) {
        User().api(["id": "\(id)"], endpoint: "users/get/", completion: completion)
    }
    
    class func get(completion: ((User?) -> ()), username: String) {
        User().api(["username": username], endpoint: "users/get/", completion: completion)
    }
    
    func update(key: String, value: String, completion: ((User?) -> ())? = nil) {
        api(["id": id!, key: value], endpoint: "users/modify/", completion: completion);
    }
    
    class func URLFromProfileImage(image: UIImage) {
        // upload and get url string
        
        return // url string
    }
    
    func populateDevices() {
        Device.get({ (devices: [Device]?) in
            self.devices = devices;
        }, UserID: self.id!);
    }
    
    // returns true if the foreign string is equal to the user's current password
    func passwordDoesMatch(foreign: String) -> Bool {
        return foreign.sha1() == password;
    }
    
    override init() {
        super.init();
    }
    
    init(dictionary: NSDictionary) {
        super.init();
        
        id = dictionary["id"] as? Int;
        username = dictionary["username"] as? String;
        password = dictionary["password"] as? String; // not cleartext
        display_name = dictionary["display_name"] as? String;
        profile_image_url = dictionary["profile_image_url"] as? String;
    }
    
    // overload Shakeel API to cast returned objects as type User
    func api(parameters: NSDictionary, endpoint: String, completion: ((User?) -> ())?){
        Shakeel.api(parameters, endpoint: endpoint) { (dictionary: NSDictionary?) in
            if(completion != nil) {
                completion?(User(dictionary: dictionary!));
            }
        }
    }
    
}
