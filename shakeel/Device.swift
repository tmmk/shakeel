//
//  Device.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Device: Shakeel {
    
    var id: Int? {
        didSet {
            if(id != nil && id != 0) {
                populateOrders();
            }
        }
    }
    var nickname: String?
    var manufacturer: String?
    var model: String?
    var imei: Int?
    var uuid: String?  // device-unique random id
    var warranty_status: WarrantyStatus?
    var orders: [Order]?
    var isSelf: Bool? {
        return uuid == Shakeel.UUID
    }
    
    enum WarrantyStatus {
        case Limited
        case AppleCare
        case AppleCarePlus
        case Expired
    }
    
    // to get an existing Device from the database as a Device object
    class func get(completion: ((Device?) -> ()), id: String) {
        Device().api(["id": id], endpoint: "devices/get/", completion: completion)
    }
    
    // to get existing Devices from the database as an array of Device objects
    class func get(completion: (([Device]?) -> ()), UserID: Int) {
        Shakeel.api(["UserID": "\(UserID)"], endpoint: "devices/get/") { (dictionary: NSDictionary?) in
            var devices: [Device]?;
            if(dictionary == nil) {
                completion(devices);
                return;
            }
            for (_, device) in dictionary! {
                devices?.append(Device(dictionary: device as! NSDictionary));
            }
            completion(devices);
        }
    }
    
    func populateOrders() {
        Order.get({ (orders: [Order]?) in
            self.orders = orders;
            }, DeviceID: self.id!);
    }
    
    override init() {
        super.init();
    }
    
    init(dictionary: NSDictionary) {
        super.init();
        
        id = dictionary["id"] as? Int;
        nickname = dictionary["nickname"] as? String;
        manufacturer = dictionary["manufacturer"] as? String;
        model = dictionary["model"] as? String;
        imei = dictionary["imei"] as? Int;
        uuid = dictionary["uuid"] as? String;
        if let warrantyStatus = dictionary["warranty_status"] {
            switch warrantyStatus as! String {
            case "Limited":
                warranty_status = WarrantyStatus.Limited;
                break;
            case "AppleCare":
                warranty_status = WarrantyStatus.AppleCare;
                break;
            case "AppleCarePlus":
                warranty_status = WarrantyStatus.AppleCarePlus;
                break;
            default:
                warranty_status = WarrantyStatus.Expired;
                break;
            }
        }
        
        populateOrders();
    }
    
    // overload Shakeel API to cast returned objects as type Device
    func api(parameters: NSDictionary, endpoint: String, completion: ((Device?) -> ())?){
        Shakeel.api(parameters, endpoint: endpoint) { (dictionary: NSDictionary?) in
            if(completion != nil) {
                completion?(Device(dictionary: dictionary!));
            }
        }
    }
    
}
