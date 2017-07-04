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
    public static var currentUser: IGUser?
    public static var currentDevice: IGDevice?
    public static var currrentNode: IGNode?
    public static var currentSensor: IGSensor?
    
    public static func getHeaders() -> HTTPHeaders {
        let headers = [
            "Authorization": "Bearer \(currentUser?.accessToken ?? "")",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    public static func isLoggedIn() -> Bool {
        if let _ = currentUser?.accessToken { return true }
        else { return false }
    }
    
    public static func login(username: String, password: String, completion: @escaping (_ user: IGUser) -> ()) {
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
                    let user = IGUser(json: json)
                    completion(user)
                }
            case .failure:
                print(response.description)
            }
        }
    }
    
    public static func register(appKey: String = APP_KEY, brand: String, firstName: String, lastName: String, mail: String, password: String, profileName: String, completion: @escaping (_ response: JSON) -> ()) {
        let parameters: Parameters = [
            "appKey": appKey,
            "brand": brand,
            "firstName": firstName,
            "lastName": lastName,
            "mail": mail,
            "password": password,
            "profileName": profileName
        ]
        Alamofire.request(endpoints.register, method: .post, parameters: parameters).responseJSON { (response) in
            print(response.description)
        }
    }
    
    public static func refreshToken() {
        
    }
    
    public static func getDevices(completion: @escaping (_ devices: [IGDevice]) -> ()) {
        if isLoggedIn() {
            Alamofire.request(endpoints.device, headers: getHeaders()).responseJSON { (response) in
                print(response.description)
                if let data = response.data {
                    let json = JSON(data: data)
                    if let array = json["content"].array {
                        var devices = [IGDevice]()
                        for json in array {
                            let device = IGDevice(json: json)
                            devices.append(device)
                        }; completion(devices)
                    }
                }
            }
        }
    }
    
    public static func getDeviceNodes(deviceId: String, pageSize: Int, completion: @escaping (_ nodes: [IGNode]) -> ()) {
        let parameters: Parameters = [
            "device": deviceId,
            "pageSize": pageSize
        ]
        Alamofire.request(endpoints.nodes, parameters: parameters, headers: getHeaders()).responseJSON { (response) in
            print(response.description)
            if let data = response.data {
                let json = JSON(data: data)
                if let array = json["list"].array {
                    var nodes = [IGNode]()
                    for json in array {
                        let node = IGNode(json: json)
                        nodes.append(node)
                    }; completion(nodes)
                }

            }
        }
    }
    
    public static func getDeviceSensors(deviceId: String, nodeId: String, pageSize: Int, completion: @escaping (_ sensors: [IGSensor]) -> ()) {
        let parameters: Parameters  = [
            "device": deviceId,
            "node": nodeId,
            "pageSize": pageSize
        ]
        Alamofire.request(endpoints.sensors, parameters: parameters, headers: getHeaders()).responseJSON { (response) in
            print(response.description)
            if let data = response.data {
                let json = JSON(data: data)
                if let array = json["list"].array {
                    var sensors = [IGSensor]()
                    for json in array {
                        let sensor = IGSensor(json: json)
                        sensors.append(sensor)
                    }; completion(sensors)
                }
            }
        }
    }
    
    public static func getSensorData(deviceId: String, nodeId: String, sensorId: String, startDate: TimeInterval = 0.0, endDate: TimeInterval, pageSize: Int, completion: @escaping (_ sensorData: [IGSensorData]) -> ()) {
        let parameters: Parameters = [
            "nodeId": nodeId,
            "sensorId": sensorId,
            "startDate": Int(startDate),
            "endDate": Int(endDate),
            "pageSize": pageSize
        ]
        Alamofire.request(endpoints.sensorData(deviceId: deviceId), parameters: parameters, headers: getHeaders()).responseJSON { (response) in
            print(response.description)
            if let data = response.data {
                if let array = JSON(data: data)["list"].array {
                    var sensorData = [IGSensorData]()
                    for json in array {
                        let sensor = IGSensorData(json: json)
                        sensorData.append(sensor)
                    }; completion(sensorData)
                }
            }
        }
    }
    
    public struct Endpoints {
        
        let base: String! = API_URL
        let login: String!
        let register: String!
        let device: String!
        let nodes: String!
        let sensors: String!
        func sensorData(deviceId: String) -> String {
            return device + "/\(deviceId)/sensor-data-history"
        }
        
        init() {
            login = base + "/login/oauth"
            register = base + "/public/create-restricted-user"
            device = base + "/device"
            nodes = device + "/iotlabel/all-nodes/"
            sensors = device + "/iotlabel/all-sensors"
        }
        
    }
    
}
