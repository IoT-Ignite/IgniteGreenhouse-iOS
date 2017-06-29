//
//  Device.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Device {
    
    let deviceId: String!
    var state: String!
    var clientIp: String!
    
    init(json: JSON) {
        deviceId = json["deviceId"].string
        state = json["presence"]["state"].string
        clientIp = json["presence"]["clientIp"].string
    }
}
