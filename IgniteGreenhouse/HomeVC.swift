//
//  HomeVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 18/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var sensorData = [IGSensorData]()
    var startDate: TimeInterval?
    var endDate: TimeInterval?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        collectionView.addSubview(refreshControl)
        IgniteAPI.refreshToken { (user) in
            IgniteAPI.currentUser = user
            self.refreshData(self.refreshControl)
        }
    }
    
    func registerNibs() {
        let nib = UINib(nibName: "GraphCell", bundle: nil)
        let nib2 = UINib(nibName: "TableCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "graphCell")
        collectionView.register(nib2, forCellWithReuseIdentifier: "tableCell")
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) { }
    
    @IBAction func optionsPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toOptions", sender: nil)
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        viewDeckController?.open(.left, animated: true)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl) {
        if let device = IgniteAPI.currentDevice, let node = IgniteAPI.currrentNode, let sensor = IgniteAPI.currentSensor {
            refreshControl.beginRefreshing()
            IgniteAPI.getSensorDataHistory(deviceId: device.deviceId, nodeId: node.nodeId, sensorId: sensor.sensorId, startDate: startDate, endDate: endDate, pageSize: 10) { (sensorData) in
                self.sensorData = sensorData
                self.collectionView.reloadData()
                refreshControl.endRefreshing()
            }
        } else {
            print("Select Device, Node and Sensor first!.")
            let alert = UIAlertController(title: "Alert", message: "Select Device, Node and Sensor first!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "toDevices", sender: nil)
            })
            alert.addAction(action)
            parent?.present(alert, animated: true) {
                refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Collection View Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sensorData.count == 0 { return 0 }
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "graphCell", for: indexPath) as! GraphCell
            cell.isHidden = true
            cell.configureCell(title: IgniteAPI.currentSensor?.sensorId, sensorData: sensorData)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell", for: indexPath) as! TableCell
            cell.isHidden = true
            cell.configureCell(sensorData: sensorData)
            return cell
        default:
            break
        }; return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width, height: 220)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 340)
        default:
            return collectionViewLayout.collectionViewContentSize
        }
    }
    
}
