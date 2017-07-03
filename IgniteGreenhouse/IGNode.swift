//
//  IGNode.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGNode {
    
    let nodeId: String!
    
    init(json: JSON) {
        nodeId = json["nodeId"].string
    }
    
}
