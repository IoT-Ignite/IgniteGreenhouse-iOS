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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    var sensor: IGSensor!
    var vc: SensorsVC!
    
    func configureCell(sensor: IGSensor, vc: SensorsVC) {
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
    }
    
//    @IBAction func infoPressed(sender: UIButton) {
//        vc.selectedDevice = device
//        let maskView = UIView(frame: vc.view.frame)
//        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        vc.view.addSubview(maskView)
//        vc.performSegue(withIdentifier: "toGateway", sender: maskView)
//    }

}
