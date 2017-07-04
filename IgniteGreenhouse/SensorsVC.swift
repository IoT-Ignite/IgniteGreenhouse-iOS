//
//  SensorsVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import SideMenu

class SensorsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var sensors = [IGSensor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        if let device = IgniteAPI.currentDevice, let node = IgniteAPI.currrentNode {
            IgniteAPI.getDeviceSensors(deviceId: device.deviceId, nodeId: node.nodeId, pageSize: 10) { (sensors) in
                self.sensors = sensors
                self.tableView.reloadData()
            }
        } else {
            print("Device or Node not yet selected.")
            self.showAlert(title: "Alert", message: "Device or Node not yet selected!")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sensorCell", for: indexPath)
        cell.textLabel?.text = sensors[indexPath.row].sensorId
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let start = dateFormatter.date(from: "2017-06-29 09:00:00")!.timeIntervalSince1970
//        let end = dateFormatter.date(from: "2017-06-29 17:00:00")!.timeIntervalSince1970
        navigationController?.popToRootViewController(animated: true)
    }
    
}
