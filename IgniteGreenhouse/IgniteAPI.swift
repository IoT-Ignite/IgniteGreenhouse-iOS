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
    public static var currentUser: IGUser? {
        get {
            guard
                let data = UserDefaults.standard.data(forKey: "currentUser"),
                let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? IGUser
                else { return nil }
            return user
        } set {
            if let value = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: value)
                UserDefaults.standard.set(data, forKey: "currentUser")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentUser")
            }
        }
    }
    public static var currentDevice: IGDevice? {
        get {
            guard
                let data = UserDefaults.standard.data(forKey: "currentDevice"),
                let device = NSKeyedUnarchiver.unarchiveObject(with: data) as? IGDevice
                else { return nil }
            return device
        } set {
            if let value = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: value)
                UserDefaults.standard.set(data, forKey: "currentDevice")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentDevice")
            }
        }
    }
    public static var currrentNode: IGNode? {
        get {
            guard
                let data = UserDefaults.standard.data(forKey: "currentNode"),
                let node = NSKeyedUnarchiver.unarchiveObject(with: data) as? IGNode
                else { return nil }
            return node
        } set {
            if let value = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: value)
                UserDefaults.standard.set(data, forKey: "currentNode")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentNode")
            }
        }
    }
    public static var currentSensor: IGSensor? {
        get {
            guard
                let data = UserDefaults.standard.data(forKey: "currentSensor"),
                let sensor = NSKeyedUnarchiver.unarchiveObject(with: data) as? IGSensor
                else { return nil }
            return sensor
        } set {
            if let value = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: value)
                UserDefaults.standard.set(data, forKey: "currentSensor")
            } else {
                UserDefaults.standard.removeObject(forKey: "currentSensor")
            }
        }
    }
    
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
            case .success(let value):
                let json = JSON(value)
                let user = IGUser(json: json)
                completion(user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func register(appKey: String = APP_KEY, brand: String = "DGtech", firstName: String, lastName: String, mail: String = TENANT_MAIL, password: String, profileName: String, completion: @escaping (_ response: JSON) -> ()) {
        let resource: Parameters = [
            "appKey": appKey,
            "brand": brand,
            "firstName": firstName,
            "lastName": lastName,
            "mail": mail,
            "password": password,
            "profileName": profileName
        ]
        let parameters: Parameters = [
            "resource": resource
        ]
        Alamofire.request(endpoints.register, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func refreshToken() {
        
    }
    
    public static func forgotPassword(alias: String = "IoT-Ignite", mail: String, mailSender: String = "noreply@ardich.com", completion: @escaping (_ response: JSON) -> ()) {
        let parameters: Parameters = [
            "resource": [
                "fromAlias": alias,
                "mail": mail,
                "mailSender": mailSender,
                "url": "https://iot-ignite.com"
            ]
        ]
        Alamofire.request(endpoints.forgotPassword, method: .put, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func changePassword(completion: @escaping (_ response: JSON) -> ()) {
        
    }
    
    public static func logout() {
        currentUser = nil
        currentDevice = nil
        currrentNode = nil
        currentSensor = nil
    }
    
    public static func getDevices(completion: @escaping (_ devices: [IGDevice]) -> ()) {
        if isLoggedIn() {
            Alamofire.request(endpoints.device, headers: getHeaders()).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let array = json["content"].array {
                        var devices = [IGDevice]()
                        for json in array {
                            let device = IGDevice(json: json)
                            devices.append(device)
                        }; completion(devices)
                    }
                case .failure(let error):
                    print(error)
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
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let array = json["list"].array {
                    var nodes = [IGNode]()
                    for json in array {
                        let node = IGNode(json: json)
                        nodes.append(node)
                    }; completion(nodes)
                }
            case .failure(let error):
                print(error)
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
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let array = json["list"].array {
                    var sensors = [IGSensor]()
                    for json in array {
                        let sensor = IGSensor(json: json)
                        sensors.append(sensor)
                    }; completion(sensors)
                }
            case .failure(let error):
                print(error)
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
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let array = json["list"].array {
                    var sensorData = [IGSensorData]()
                    for json in array {
                        let sensor = IGSensorData(json: json)
                        sensorData.append(sensor)
                    }; completion(sensorData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public static func getDromTenantConfig(completion: @escaping (_ response: JSON) -> ()) {
        Alamofire.request(endpoints.dromTenantConfiguration, headers: getHeaders()).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public struct Endpoints {
        
        let base: String! = API_URL
        let login: String!
        let register: String!
        let forgotPassword: String!
        let changePassword: String!
        let device: String!
        let nodes: String!
        let sensors: String!
        func sensorData(deviceId: String) -> String {
            return device + "/\(deviceId)/sensor-data-history"
        }
        let dromTenantConfiguration: String!
        
        init() {
            login = base + "/login/oauth"
            register = base + "/public/create-restricted-user"
            forgotPassword = base + "/login/password/forget"
            changePassword =  base + "/login/password/change"
            device = base + "/device"
            nodes = device + "/iotlabel/all-nodes/"
            sensors = device + "/iotlabel/all-sensors"
            dromTenantConfiguration = base + "/drom-tenant-configuration"
        }
        
    }
    
}
