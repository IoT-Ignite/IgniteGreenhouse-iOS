//
//  GatewayVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 14.10.2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class GatewayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    weak var device: IGDevice!
    var keys = [String]()
    weak var maskView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        keys = ["Model", "OS Version", "Agent Version", "Network Type", "Public IP", "Local IP"]
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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Gateway Specifications"
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

}
