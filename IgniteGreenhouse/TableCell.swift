//
//  TableCell.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 18/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class TableCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var sensorData: [IGSensorData]?
    
    func configureCell(sensorData: [IGSensorData]) {
        backgroundColor = UIColor.flatBlue()
        layer.cornerRadius = 20
        self.sensorData = sensorData
        tableView.reloadData()
    }
    
    // MARK: - Table View Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = sensorData {
            return data.count
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = sensorData?[indexPath.row].data
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = sensorData?[indexPath.row].data
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sensorData = sensorData else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(sensorData[indexPath.row].cloudDate))
        showAlert(title: sensorData[indexPath.row].data, message: "\(sensorData[indexPath.row].deviceId!)\n\(sensorData[indexPath.row].nodeId!)\n\(sensorData[indexPath.row].sensorId!)\n\(dateFormatter.string(from: date))")
    }

}
