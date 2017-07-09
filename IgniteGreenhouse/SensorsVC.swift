//
//  SensorsVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class SensorsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var sensors = [IGSensor]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SensorsVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshData(refreshControl)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        if let device = IgniteAPI.currentDevice, let node = IgniteAPI.currrentNode {
            IgniteAPI.getDeviceSensors(deviceId: device.deviceId, nodeId: node.nodeId, pageSize: 10) { (sensors) in
                self.sensors = sensors
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        } else {
            print("Device or Node not yet selected.")
            changeVC(withIdentifier: "HomeVC")
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
        IgniteAPI.currentSensor = sensors[indexPath.row]
        changeVC(withIdentifier: "HomeVC")
    }
    
}
