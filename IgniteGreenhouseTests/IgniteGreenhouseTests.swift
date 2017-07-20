//
//  IgniteGreenhouseTests.swift
//  IgniteGreenhouseTests
//
//  Created by Doruk Gezici on 14/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import XCTest
import SwiftyJSON
import IgniteAPI

class IgniteGreenhouseTests: XCTestCase {
    
    let APP_KEY = "2bb69ddce24f4021a1c6b77f1ab9302c"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let ex = expectation(description: "Logging in")
        IgniteAPI.login(username: "greenhouse@iot-ignite.com", password: "gr33nhous3") { (user) in
            IgniteAPI.currentUser = user
            IgniteAPI.getDevices { (devices) in
                guard let device = devices.first else { return }
                IgniteAPI.currentDevice = device
                IgniteAPI.getDeviceNodes(deviceId: device.deviceId, pageSize: 10) { (nodes) in
                    guard let node = nodes.first else { return }
                    IgniteAPI.currrentNode = nodes.first
                    IgniteAPI.getDeviceSensors(deviceId: device.deviceId, nodeId: node.nodeId, pageSize: 10) { (sensors) in
                        IgniteAPI.currentSensor = sensors.first
                        ex.fulfill()
                    }
                }
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        IgniteAPI.logout()
        super.tearDown()
    }
    
    func testMessageModel() {
        let thing = Thing(thingCode: "10010001", thingId: "Temperature")
        let thing2 = Thing(thingCode: "10020001", thingId: "Humidity")
        let node = Node(nodeId: "Doruk1", things: [thing, thing2])
        let thing3 = Thing(thingCode: "12010001", thingId: "Temperature")
        let thing4 = Thing(thingCode: "12020001", thingId: "Humidity")
        let node2 = Node(nodeId: "Doruk2", things: [thing3, thing4])
        let message = Message(nodes: [node, node2])
        let ex = expectation(description: "Sending action message.")
        IgniteAPI.sendSensorAgentMessage(deviceCode: "d49ffa4e10f1457996d0ae5826fe3cb9", nodeId: "Configurator", sensorId: "Configurator Thing", message: message.json.description) { (messageId) in
            print(messageId)
            ex.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
