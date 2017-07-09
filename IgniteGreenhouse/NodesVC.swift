//
//  NodesVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class NodesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var nodes = [IGNode]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NodesVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshData(refreshControl)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        if let device = IgniteAPI.currentDevice {
            IgniteAPI.getDeviceNodes(deviceId: device.deviceId, pageSize: 10) { (nodes) in
                self.nodes = nodes
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        } else {
            print("Device not yet selected.")
            changeVC(withIdentifier: "HomeVC")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nodeCell", for: indexPath)
        cell.textLabel?.text = nodes[indexPath.row].nodeId
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IgniteAPI.currrentNode = nodes[indexPath.row]
        performSegue(withIdentifier: "toSensors", sender: nil)
    }

}
