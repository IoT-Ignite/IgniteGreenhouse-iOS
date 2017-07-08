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
    var sensorData = [IGSensorData]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        refreshData(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshData(refreshControl)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        cell.textLabel?.text = "\(sensorData[indexPath.row].data!) Celcius"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(sensorData[indexPath.row].cloudDate))
        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(title: sensorData[indexPath.row].data, message: "\(sensorData[indexPath.row].deviceId!)\n\(sensorData[indexPath.row].nodeId!)\n\(sensorData[indexPath.row].sensorId!)")
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        viewDeckController?.open(.left, animated: true)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        if let device = IgniteAPI.currentDevice, let node = IgniteAPI.currrentNode, let sensor = IgniteAPI.currentSensor {
            IgniteAPI.getSensorData(deviceId: device.deviceId, nodeId: node.nodeId, sensorId: sensor.sensorId, endDate: Date().timeIntervalSince1970, pageSize: 10) { (sensorData) in
                self.sensorData = sensorData
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
        } else {
            print("Select Device, Node and Sensor first!.")
            let alert = UIAlertController(title: "Alert", message: "Select Device, Node and Sensor first!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "toDevices", sender: nil)
            })
            alert.addAction(action)
//            present(alert, animated: true, completion: {
//                refreshControl.endRefreshing()
//            })
        }
    }
    
}
