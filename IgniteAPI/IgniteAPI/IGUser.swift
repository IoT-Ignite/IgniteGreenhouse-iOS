//
//  IGUser.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IGUser: NSObject, NSCoding {
    
    let accessToken: String!
    let expiresIn: String!
    let refreshToken: String!
    let scope: String!
    let tokenType: String!
    
    init(json: JSON) {
        accessToken = json["access_token"].string
        expiresIn = json["expires_in"].string
        refreshToken = json["refresh_token"].string
        scope = json["scope"].string
        tokenType = json["token_type"].string
    }
    
    required public init(coder aDecoder: NSCoder) {
        accessToken = aDecoder.decodeString(forKey: "accessToken")
        expiresIn = aDecoder.decodeString(forKey: "expiresIn")
        refreshToken = aDecoder.decodeString(forKey: "refreshToken")
        scope = aDecoder.decodeString(forKey: "scope")
        tokenType = aDecoder.decodeString(forKey: "tokenType")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(expiresIn, forKey: "expiresIn")
        aCoder.encode(refreshToken, forKey: "refreshToken")
        aCoder.encode(scope, forKey: "scope")
        aCoder.encode(tokenType, forKey: "tokenType")
    }
    
}
