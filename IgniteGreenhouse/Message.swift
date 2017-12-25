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
    
    init(messageId: String, nodes: [Node]) {
        json = [
            "messageId": messageId,
            "addDevice": nodes.map { $0.json! }
        ]
    }
    
}
