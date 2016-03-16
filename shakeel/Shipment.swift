//
//  Shipment.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Shipment: NSObject {
    
    var id: Int?
    var price: Double?
    var shipper: String?
    var tracking_number: String?
    var direction: Direction?
    var comment: String?
    
    enum Direction {
        case Inbound
        case Outbound
    }

}
