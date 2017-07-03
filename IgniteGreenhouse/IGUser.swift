//
//  IGUser.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGUser {
    
    let accessToken: String!
    let expiresIn: Int!
    let refreshToken: String!
    let scope: String!
    let tokenType: String!
    
    init(json: JSON) {
        accessToken = json["access_token"].string
        expiresIn = json["expires_in"].int
        refreshToken = json["refresh_token"].string
        scope = json["scope"].string
        tokenType = json["token_type"].string
    }
    
}
