//
//  Node.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Node {
    
    let json: JSON!
    let nodeId: String!
    var things: [Thing]!
    
    init(nodeId: String, things: [Thing]) {
        self.nodeId = nodeId
        self.things = things
        json = [
            "nodeId": nodeId,
            "things": things.map { $0.json! }
        ]
    }
    
}
