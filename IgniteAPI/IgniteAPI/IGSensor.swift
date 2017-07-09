//
//  IGSensor.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGSensor: NSObject, NSCoding {
    
    public let nodeId: String!
    public let sensorId: String!
    
    init(json: JSON) {
        nodeId = json["nodeId"].string
        sensorId = json["sensorId"].string
    }
    
    public required init?(coder aDecoder: NSCoder) {
        nodeId = aDecoder.decodeString(forKey: "nodeId")
        sensorId = aDecoder.decodeString(forKey: "sensorId")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(nodeId, forKey: "nodeId")
        aCoder.encode(sensorId, forKey: "sensorId")
    }
    
}
