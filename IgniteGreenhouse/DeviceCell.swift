//
//  DeviceCell.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var deviceImage: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    
    func configureCell(device: IGDevice) {
        idLabel.text = device.deviceId
        statusLabel.text = device.state
        switch device.state {
        case "ONLINE":
            statusImage.image = UIImage(named: "online")
        case "OFFLINE":
            statusImage.image = UIImage(named: "offline")
        default:
            break
        }
    }
    
}
