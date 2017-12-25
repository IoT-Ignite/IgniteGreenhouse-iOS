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

    @IBOutlet weak var sensorName: UITextField!
    var thingCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        guard let sensorId = sensorName.text else { return }
        let thing = Thing(thingCode: thingCode, thingId: sensorId)
        let node = Node(nodeId: "IgniteGreenhouse", things: [thing])
        let message = Message(nodes: [node])
        
        IgniteAPI.sendSensorAgentMessage(deviceCode: IgniteAPI.currentDevice!.code, nodeId: "Configurator", sensorId: "Configurator Thing", message: message.json.description) { (messageId) in
            IgniteAPI.getActionSummary(responseId: messageId, completion: { (json) in
                print(json.description)
                let alert = UIAlertController(title: "Sensor Status", message: json["appliedStatus"].stringValue, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.changeVC(withIdentifier: "SensorsVC")
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            })
        }
    }
    
}
