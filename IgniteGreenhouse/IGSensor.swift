//
//  IGSensor.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGSensor {
    
    let nodeId: String!
    let sensorId: String!
    
    init(json: JSON) {
        nodeId = json["nodeId"].string
        sensorId = json["sensorId"].string
    }
    
}
