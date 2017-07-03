//
//  IGDevice.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGDevice {
    
    let deviceId: String!
    let status: String!
    let osVersion: String!
    let model: String!
    let label: String!
    var state: String!
    var clientIp: String!
    let code: String!
    
    init(json: JSON) {
        deviceId = json["deviceId"].string
        status = json["status"].string
        osVersion = json["osVersion"].string
        model = json["model"].string
        label = json["label"].string
        state = json["presence"]["state"].string
        clientIp = json["presence"]["clientIp"].string
        code = json["code"].string
    }
}
