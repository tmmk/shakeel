//
//  Order.swift
//  shakeel
//
//  Created by mny on 3/13/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class Order: Shakeel {
    
    var id: Int?
    var device: Device?
    var price: Double?
    var shipment: Shipment?
    var cause: ProblemCause?
    var writeup: String?
    var status: OrderStatus?
    var chat: Thread?
    
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
    
    // to get an existing Order from the database as a Order object
    class func get(completion: ((Order?) -> ()), id: String) {
        Order().api(["id": id], endpoint: "orders/get/", completion: completion)
    }
    
    // to get existing Orders from the database as an array of Order objects
    class func get(completion: (([Order]?) -> ()), DeviceID: Int) {
        Shakeel.api(["DeviceID": "\(DeviceID)"], endpoint: "orders/get/") { (dictionary: NSDictionary?) in
            var orders: [Order]?;
            if(dictionary == nil) {
                completion(orders);
                return;
            }
            for (_, order) in dictionary! {
                orders?.append(Order(dictionary: order as! NSDictionary));
            }
            completion(orders);
        }
    }
    
    override init() {
        super.init();
    }
    
    init(dictionary: NSDictionary) {
        
    }

    // overload Shakeel API to cast returned objects as type Order
    func api(parameters: NSDictionary, endpoint: String, completion: ((Order?) -> ())?){
        Shakeel.api(parameters, endpoint: endpoint) { (dictionary: NSDictionary?) in
            if(completion != nil) {
                completion?(Order(dictionary: dictionary!));
            }
        }
    }
    
}
