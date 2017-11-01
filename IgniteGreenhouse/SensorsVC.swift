//
//  SensorsVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 30/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI
import NVActivityIndicatorView

class SensorsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var sensors = [IGSensor]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SensorsVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addSubview(refreshControl)
        refreshData(refreshControl)
        let nib = UINib(nibName: "SensorCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "sensorCell")
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        startAnimating(message: "Loading sensors...", type: NVActivityIndicatorType.ballTrianglePath)
        if let device = IgniteAPI.currentDevice, let node = IgniteAPI.currrentNode {
            IgniteAPI.getDeviceSensors(deviceId: device.deviceId, nodeId: node.nodeId, pageSize: 10) { (sensors) in
                self.sensors = sensors
                self.collectionView.reloadData()
                self.stopAnimating()
                refreshControl.endRefreshing()
            }
        } else {
            print("Device or Node not yet selected.")
            self.stopAnimating()
            refreshControl.endRefreshing()
            changeVC(withIdentifier: "HomeVC")
        }
    }
    
    // MARK: - Collection View Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sensors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sensorCell", for: indexPath) as? SensorCell {
            cell.configureCell(sensor: sensors[indexPath.row], vc: self)
            return cell
        } else { return UICollectionViewCell() }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        IgniteAPI.currentSensor = sensors[indexPath.row]
        changeVC(withIdentifier: "HomeVC")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsetsMake(16, 0, 16, 0)
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
}
