//
//  Order.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Order: NSObject {
    
    var id: Int?
    var device: Device?
    var price: Double?
    var shipment: Shipment?
    var cause: ProblemCause?
    var writeup: String?
    var status: OrderStatus?
    
    enum ProblemCause {
        case Accident
        case Degradation
        case PreviousBadRepair
    }
    
    enum OrderStatus {
        case Draft
        case Paid
        case Shipped
        case Servicing
        case Returned
        case Received
        case Archived
    }
    
    var screen_state: ScreenStatus?
    
    enum ScreenStatus {
        case Working
        case TouchNotWorking
        case GlassCracked
        case GlassAndLCD
    }
    
    var isScreenBroken: Bool?
    var isHomeButtonIssue: Bool?
    var isLockButtonIssue: Bool?
    var isVolumeButtonIssue: Bool?
    var isCameraIssue: Bool?
    var isBatteryDrainsQuickly: Bool?
    var isBatteryNotCharging: Bool?
    var isWaterDamaged: Bool?
    var isWontTurnOn: Bool?
    var isOtherIssue: Bool?      // if none of the above

}
