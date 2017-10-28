//
//  DevicesVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 04/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI

class DevicesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var devices = [IGDevice]()
    var selectedDevice: IGDevice!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DevicesVC.refreshData(_:)), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addSubview(refreshControl)
        refreshData(refreshControl)
        let nib = UINib(nibName: "DeviceCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "deviceCell")
    }
    
    @IBAction func addPressed(_ sender: Any) {
        IgniteAPI.login(username: MASTER_MAIL, password: MASTER_PASS, completion: { (master, error) in
            Utilities.masterUser = master
            self.performSegue(withIdentifier: "toQRScanner", sender: nil)
        })
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        IgniteAPI.getDevices { (devices) in
            self.devices = devices
            self.collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Collection View Delegate Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCell", for: indexPath) as! DeviceCell
        cell.configureCell(device: devices[indexPath.row], vc: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        IgniteAPI.currentDevice = devices[indexPath.row]
        performSegue(withIdentifier: "toSensors", sender: nil)
        //performSegue(withIdentifier: "toNodes", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsetsMake(16, 0, 16, 0)
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "toSensors":
            guard let destVC = segue.destination as? SensorsVC,
                let deviceId = IgniteAPI.currentDevice?.deviceId else { return }
            IgniteAPI.getDeviceSensors(deviceId: deviceId, nodeId: "IgniteGreenhouse", pageSize: 1, completion: { (sensors) in
                destVC.sensors = sensors
                destVC.refreshData(destVC.refreshControl)
            })
        case "toQRScanner":
            guard let destVC = segue.destination as? QRScannerVC else { return }
            destVC.mode = .device
        case "toGateway":
            guard let destVC = segue.destination as? GatewayVC else { return }
            destVC.device = selectedDevice
            destVC.popoverPresentationController!.delegate = self
            destVC.popoverPresentationController?.sourceView = view
            destVC.popoverPresentationController?.sourceRect = CGRect(x: view.frame.midX, y: collectionView.frame.minY, width: 0, height: 0)
            destVC.preferredContentSize = CGSize(width: view.bounds.width * 0.8, height: collectionView.bounds.height * 0.8)
        default:
            break
        }
        
    }
    
}

