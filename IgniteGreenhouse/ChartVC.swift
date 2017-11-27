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
    var reading_a = Array(0...99)
    var reading_b = Array(0...99)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //charts
        self.lineChartView.delegate = self
        let set_a: LineChartDataSet = LineChartDataSet(values: [ChartDataEntry](), label: "a")
        set_a.drawCirclesEnabled = false
        set_a.setColor(UIColor.blue)
        
        let set_b: LineChartDataSet = LineChartDataSet(values: [ChartDataEntry](), label: "b")
        set_b.drawCirclesEnabled = false
        set_b.setColor(UIColor.green)
        
        self.lineChartView.data = LineChartData(dataSets: [set_a, set_b])
        
        _ = Timer.scheduledTimer(timeInterval: 0.010, target:self, selector: #selector(ChartVC.updateCounter), userInfo: nil, repeats: true)
    }
    
    
    // add point
    var i = 0
    @objc func updateCounter() {
        self.lineChartView.data?.addEntry(ChartDataEntry(x: Double(reading_a[i]), y: Double(i)), dataSetIndex: 0)
        self.lineChartView.data?.addEntry(ChartDataEntry(x: Double(reading_b[i]), y: Double(i)), dataSetIndex: 1)
//        self.lineChartView.data?.addXValue(String(i))
        self.lineChartView.setVisibleXRange(minXRange: Double(CGFloat(1)), maxXRange: Double(CGFloat(50)))
        self.lineChartView.notifyDataSetChanged()
        self.lineChartView.moveViewToX(Double(i))
        i = i + 1
    }

}
