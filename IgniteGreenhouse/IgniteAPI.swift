//
//  IgniteAPI.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class IgniteAPI {
    
    public static var endpoints: Endpoints = Endpoints()
    public static var currentUser: User?
    
    public static func login(username: String, password: String, completion: @escaping (_ response: JSON) -> ()) {
        let parameters: Parameters = [
            "grant_type": "password",
            "username": username,
            "password": password
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Basic ZnJvbnRlbmQ6",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        Alamofire.request(endpoints.login, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let json = JSON(data)
                    currentUser = User(json: json)
                    completion(json)
                }
            case .failure:
                print(response.description)
            }
        }
    }
    
    public static func refreshToken() {
    
    }
    
    public static func getDevices(completion: @escaping (_ devices: [Device]) -> ()) {
        if let token = currentUser?.accessToken {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            Alamofire.request(endpoints.device, headers: headers).responseJSON { (response) in
                if let data = response.data {
                    let json = JSON(data: data)
                    if let array = json["content"].array {
                        var devices = [Device]()
                        for json in array {
                            let device = Device(json: json)
                            devices.append(device)
                        }; completion(devices)
                    }
                }
            }
        }
    }
    
    public struct Endpoints {
        let base: String! = API_URL
        let login: String!
        let device: String!
        init() {
            login = base + "/login/oauth"
            device = base + "/device"
        }
    }
    
}
