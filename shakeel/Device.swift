//
//  Device.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Device: NSObject {
    
    var manufacturer: String?
    var model: String?
    var serial_number: String?
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

}
