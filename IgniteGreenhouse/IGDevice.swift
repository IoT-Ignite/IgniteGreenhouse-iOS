//
//  IGDevice.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGDevice: NSObject, NSCoding {
    
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
    
    required public init(coder aDecoder: NSCoder) {
        deviceId = aDecoder.decodeString(forKey: "deviceId")
        status = aDecoder.decodeString(forKey: "status")
        osVersion = aDecoder.decodeString(forKey: "osVersion")
        model = aDecoder.decodeString(forKey: "model")
        label = aDecoder.decodeString(forKey: "label")
        state = aDecoder.decodeString(forKey: "state")
        clientIp = aDecoder.decodeString(forKey: "clientIp")
        code = aDecoder.decodeString(forKey: "code")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(deviceId, forKey: "deviceId")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(osVersion, forKey: "osVersion")
        aCoder.encode(model, forKey: "model")
        aCoder.encode(label, forKey: "label")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(clientIp, forKey: "clientIp")
        aCoder.encode(code, forKey: "code")
    }
    
}
