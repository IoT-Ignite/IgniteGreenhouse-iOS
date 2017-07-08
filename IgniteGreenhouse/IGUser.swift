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
    
    required public init(coder decoder: NSCoder) {
        self.accessToken = decoder.decodeString(forKey: "accessToken")
        self.expiresIn = decoder.decodeString(forKey: "expiresIn")
        self.refreshToken = decoder.decodeString(forKey: "refreshToken")
        self.scope = decoder.decodeString(forKey: "scope")
        self.tokenType = decoder.decodeString(forKey: "tokenType")
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(expiresIn, forKey: "expiresIn")
        coder.encode(refreshToken, forKey: "refreshToken")
        coder.encode(scope, forKey: "scope")
        coder.encode(tokenType, forKey: "tokenType")
    }
    
}
