//
//  IGNode.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGNode: NSObject, NSCoding {
    
    public let nodeId: String!
    
    init(json: JSON) {
        nodeId = json["nodeId"].string
    }
    
    public required init?(coder aDecoder: NSCoder) {
        nodeId = aDecoder.decodeString(forKey: "nodeId")
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(nodeId, forKey: "nodeId")
    }
    
}
