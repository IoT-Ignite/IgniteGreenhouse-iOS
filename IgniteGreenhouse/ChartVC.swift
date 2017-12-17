//
//  ChartVC.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 27.11.2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import Charts
import IgniteAPI

class ChartVC: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    weak var rootVC: SensorsVC!
    var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
        closeButton.layer.cornerRadius = 40
        homeButton.layer.cornerRadius = 40
        bgView.layer.cornerRadius = 15
        
        lineChartView.tintColor = UIColor.flatWhite
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.labelTextColor = UIColor.flatWhite
        
        let set_a = LineChartDataSet(values: [ChartDataEntry](), label: "a")
        set_a.setColor(UIColor.flatWhite)
        _ = set_a.addEntry(ChartDataEntry(x: 1.0, y: 1.0))
        
        
        let data = LineChartData(dataSet: set_a)
        lineChartView.data = data
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.addData()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        rootVC.changeVC(withIdentifier: "HomeVC")
    }
    
    @objc func addData() {
        let entry = ChartDataEntry(x: Double(i), y: Double(i))
        lineChartView.lineData?.addEntry(entry, dataSetIndex: 0)
        lineChartView.setVisibleXRange(minXRange: 1.0, maxXRange: 50.0)
        lineChartView.moveViewToX(Double(i))
        lineChartView.notifyDataSetChanged()
        i = i + 1
    }

}
