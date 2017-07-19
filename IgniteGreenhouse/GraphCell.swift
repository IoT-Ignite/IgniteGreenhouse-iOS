//
//  GraphCell.swift
//  IgniteGreenhouse
//
//  Created by Doruk Gezici on 18/07/2017.
//  Copyright © 2017 ARDIC. All rights reserved.
//

import UIKit
import IgniteAPI
import Charts

class GraphCell: UICollectionViewCell, ChartViewDelegate {

    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var label: UILabel!
    
    func configureCell(title: String?, sensorData: [IGSensorData]) {
        label.text = title
        layer.cornerRadius = 20
        backgroundColor = UIColor.flatBlue
        lineChart.delegate = self
        lineChart.backgroundColor = UIColor.flatBlue
        lineChart.tintColor = UIColor.flatWhite
        lineChart.chartDescription?.enabled = false
        lineChart.legend.enabled = false
        lineChart.xAxis.enabled = false
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.labelTextColor = UIColor.flatWhite
        var dataEntries = [ChartDataEntry]()
        for (i, sensor) in sensorData.enumerated() {
            guard let data = Double(sensor.data) else { return }
            let dataEntry = ChartDataEntry(x: Double(i), y: data)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Temperature")
        chartDataSet.setColor(UIColor.flatWhite)
        chartDataSet.drawValuesEnabled = false
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillColor = UIColor.flatWhite
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = chartData
        self.isHidden = false
    }

}
