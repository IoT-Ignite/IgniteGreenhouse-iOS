//
//  HomeVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import SideMenu

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var sensorData = [IGSensorData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        IgniteAPI.getSensorData(deviceId: "b8:27:eb:b3:68:7a@iotigniteagent", nodeId: "WeMos D1", sensorId: "LM-35 Temperature", endDate: Date().timeIntervalSince1970, pageSize: 10) { (sensorData) in
                self.sensorData = sensorData
                self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        cell.textLabel?.text = "\(sensorData[indexPath.row].data!) Celcius"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(sensorData[indexPath.row].cloudDate))
        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDevices", sender: nil)
    }
    
    @IBAction func menuPressed(_ sender: Any) {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func setupSideMenu() {
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddPanGestureToPresent(toView: self.view)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuFadeStatusBar = false
    }

}
