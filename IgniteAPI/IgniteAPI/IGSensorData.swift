//
//  IGSensorData.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGSensorData {
    
    public let cloudDate: TimeInterval!
    public let createDate: TimeInterval!
    public var data: String!
    public let deviceId: String!
    public let nodeId: String!
    public let sensorId: String!
    
    init(json: JSON) {
        cloudDate = TimeInterval(json["cloudDate"].intValue) / 1000
        createDate = TimeInterval(json["createDate"].intValue) / 1000
        if let str = json["data"].string {
            let array = str.characters.filter({ $0 != "\"" && $0 != "[" && $0 != "]" })
            self.data = String(array)
        }
        deviceId = json["deviceId"].string
        nodeId = json["nodeId"].string
        sensorId = json["sensorId"].string
    }
    
}
