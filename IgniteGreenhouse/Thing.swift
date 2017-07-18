//
//  Thing.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Thing {
    
    let json: JSON!
    let thingCode: String!
    let thingId: String!
    
    init(thingCode: String, thingId: String) {
        self.thingCode = thingCode
        self.thingId = thingId
        json = [
            "thingCode": thingCode,
            "thingId": thingId
        ]
    }
    
}
