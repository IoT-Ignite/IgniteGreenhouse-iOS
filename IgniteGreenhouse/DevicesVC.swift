//
//  DevicesVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 04/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class DevicesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var devices = [IGDevice]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DevicesVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshData(refreshControl)
        let nib = UINib(nibName: "DeviceCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "deviceCell")
    }
    
    @IBAction func addPressed(_ sender: Any) {
        performSegue(withIdentifier: "toQRScanner", sender: nil)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        IgniteAPI.getDevices { (devices) in
            self.devices = devices
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! DeviceCell
        cell.configureCell(device: devices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IgniteAPI.currentDevice = devices[indexPath.row]
        performSegue(withIdentifier: "toNodes", sender: nil)
    }
    
}

