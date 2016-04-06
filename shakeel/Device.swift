//
//  Device.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Device: NSObject {
    
    var nickname: String?
    var manufacturer: String?
    var model: String?
    var imei: Int?
    var uuid: String?  // hash of serial #
    var warranty_status: WarrantyStatus?
    var orders: [Order]?
    var isSelf: Bool? {
        return NSUUID().UUIDString == uuid
    }
    
    enum WarrantyStatus {
        case Limited
        case AppleCare
        case AppleCarePlus
        case Expired
    }
    
    init?(dictionary: NSDictionary?) {
        super.init();
        if(dictionary == nil) {
            return nil;
        }
        manufacturer = dictionary!["manufacturer"] as? String;
        model = dictionary!["model"] as? String;
        imei = dictionary!["imei"] as? Int;
        uuid = dictionary!["uuid"] as? String;
    }

}
