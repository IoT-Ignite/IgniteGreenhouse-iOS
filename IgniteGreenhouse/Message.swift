//
//  Message.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Message {
    
    let json: JSON!
    
    init(nodes: [Node]) {
        json = [
            "addDevice": nodes.map { $0.json! }
        ]
    }
    
}
