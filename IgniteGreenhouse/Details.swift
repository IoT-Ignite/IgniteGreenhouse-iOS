//
//  DetailsVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14.10.2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class DetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Mode {
        case gateway
        case sensor
    }
    
    @IBOutlet weak var tableView: UITableView!
    weak var device: IGDevice!
    weak var sensor: IGSensor!
    var keys = [String]()
    weak var maskView: UIView!
    var mode: Mode = .gateway

    override func viewDidLoad() {
        super.viewDidLoad()
        switch mode {
        case .gateway:
            keys = ["Model", "OS Version", "Agent Version", "Network Type", "Public IP", "Local IP"]
        case .sensor:
            keys = ["Node Id", "Sensor Id", "Vendor", "Sensor Type"]
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        maskView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        if indexPath.row % 2 == 0 {
            cell.textLabel?.text = keys[indexPath.row / 2]
            cell.backgroundColor = UIColor.lightGray
        } else {
            let key = keys[(indexPath.row - 1) / 2]
            switch mode {
            case .gateway:
                switch key {
                case "Model":
                    cell.textLabel?.text = device.model
                case "OS Version":
                    cell.textLabel?.text = device.osVersion
                case "Agent Version":
                    cell.textLabel?.text = "0.8.35"
                case "Network Type":
                    cell.textLabel?.text = "Wi-Fi"
                case "Public IP":
                    cell.textLabel?.text = device.clientIp
                case "Local IP":
                    cell.textLabel?.text = device.clientIp
                default:
                    break
                }
            case .sensor:
                switch key {
                case "Node Id":
                    cell.textLabel?.text = sensor.nodeId
                case "Sensor Id":
                    cell.textLabel?.text = sensor.sensorId
                case "Vendor":
                    cell.textLabel?.text = sensor.vendor
                case "Sensor Type":
                    cell.textLabel?.text = sensor.sensorType
                default:
                    break
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch mode {
        case .gateway:
            return "Gateway Specifications"
        case .sensor:
            return "Sensor Specifications"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

}
