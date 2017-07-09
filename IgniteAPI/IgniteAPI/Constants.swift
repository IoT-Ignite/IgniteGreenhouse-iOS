//
//  Constants.swift
//  IgniteAPI
//
//  Created by Doruk Gezici on 09/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

let API_URL = "https://api.ardich.com/api/v3"
let TENANT_MAIL = "greenhouse@iot-ignite.com"
let APP_KEY = "2bb69ddce24f4021a1c6b77f1ab9302c"

extension NSCoder {
    func decodeString(forKey key: String) -> String {
        return decodeObject(forKey: key) as? String ?? ""
    }
    func decodeData(forKey key: String) -> Data {
        return decodeObject(forKey: key) as? Data ?? Data()
    }
}
