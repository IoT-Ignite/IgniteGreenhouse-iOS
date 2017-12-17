//
//  AddVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 19/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class AddVC: UIViewController {

    @IBOutlet weak var nodeName: UITextField!
    @IBOutlet weak var sensorName: UITextField!
    var thingCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        guard let nodeId = nodeName.text, let sensorId = sensorName.text else { return }
        let thing = Thing(thingCode: thingCode, thingId: sensorId)
        let node = Node(nodeId: nodeId, things: [thing])
        let message = Message(nodes: [node])
        IgniteAPI.sendSensorAgentMessage(deviceCode: "d49ffa4e10f1457996d0ae5826fe3cb9", nodeId: "Configurator", sensorId: "Configurator Thing", message: message.json.description) { (messageId) in
        }
    }
    
}
