//
//  HomeVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var devices = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DeviceCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "deviceCell")
        IgniteAPI.getDevices { (devices) in
            self.devices = devices
            self.tableView.reloadData()
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

}
