//
//  HomeVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 29/06/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import Charts
import IgniteAPI

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temperatureChart: LineChartView!
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
        tableView.addSubview(refreshControl)
        refreshData(refreshControl)
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
                self.tableView.reloadData()
                self.updateChartWithData()
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
    
    func updateChartWithData() {
        var dataEntries = [ChartDataEntry]()
        for (i, sensor) in sensorData.enumerated() {
            guard let data = Double(sensor.data) else { return }
            let dataEntry = ChartDataEntry(x: Double(i), y: data)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Temperature")
        let chartData = LineChartData(dataSet: chartDataSet)
        temperatureChart.data = chartData
    }
    
    // MARK: - Table View Delegate Methods
    
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
        showAlert(title: sensorData[indexPath.row].data, message: "\(sensorData[indexPath.row].deviceId!)\n\(sensorData[indexPath.row].nodeId!)\n\(sensorData[indexPath.row].sensorId!)")
    }
    
}
