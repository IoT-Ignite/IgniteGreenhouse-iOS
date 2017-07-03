//
//  NodeVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class NodeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var sensors = [IGSensor]()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let start = dateFormatter.date(from: "2017-06-29 09:00:00")!.timeIntervalSince1970
        let end = dateFormatter.date(from: "2017-06-29 17:00:00")!.timeIntervalSince1970
        print(start, end)
        IgniteAPI.getSensorData(deviceCode: IgniteAPI.currentDevice!.code, nodeId: "WeMos D1", sensorId: "LM-35 Temperature", startDate: start, endDate: end, pageSize: 10) { (sensor) in
            print(sensor)
        }
    }
    
}
