//
//  SensorCell.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 1.11.2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class SensorCell: UICollectionViewCell {

    @IBOutlet weak var nodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deviceImage: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var sensor: IGSensor!
    var vc: SensorsVC!
    
    func configureCell(sensor: IGSensor, vc: SensorsVC) {
        dataLabel.text = ""
        dateLabel.text = ""
        clipsToBounds = false
        layer.cornerRadius = 6
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        self.sensor = sensor
        self.vc = vc
        nodeLabel.text = sensor.nodeId
        nameLabel.text = sensor.sensorId
        switch sensor.sensorId {
        case "Temperature":
            deviceImage.image = UIImage(named: "thermometer")
        case "Humidity":
            deviceImage.image = UIImage(named: "humidity")
        default:
            break
        }
        IgniteAPI.getSensorData(deviceId: IgniteAPI.currentDevice!.deviceId, nodeId: "IgniteGreenhouse", sensorId: sensor.sensorId) { (data) in
            self.dataLabel.text = data.data
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            let date = Date(timeIntervalSince1970: TimeInterval(data.cloudDate))
            self.dateLabel.text = dateFormatter.string(from: date)
            switch sensor.sensorId {
            case "Temperature":
                self.dataLabel.text! += " C"
            case "Humidity":
                self.dataLabel.text! += " %"
            default:
                break
            }
        }
    }
    
//    @IBAction func infoPressed(sender: UIButton) {
//        vc.selectedDevice = device
//        let maskView = UIView(frame: vc.view.frame)
//        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        vc.view.addSubview(maskView)
//        vc.performSegue(withIdentifier: "toGateway", sender: maskView)
//    }

}
