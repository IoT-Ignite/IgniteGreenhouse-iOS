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
    
    func configureCell(sensorData: [IGSensorData]) {
        lineChart.delegate = self
        backgroundColor = UIColor.flatBlue()
        layer.cornerRadius = 20
        lineChart.backgroundColor = UIColor.flatBlue()
        lineChart.tintColor = UIColor.flatWhite()
        lineChart.chartDescription?.enabled = false
        lineChart.legend.enabled = false
        tintColor = UIColor.flatWhite()
        var dataEntries = [ChartDataEntry]()
        for (i, sensor) in sensorData.enumerated() {
            guard let data = Double(sensor.data) else { return }
            let dataEntry = ChartDataEntry(x: Double(i), y: data)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Temperature")
        chartDataSet.setColor(UIColor.flatRed())
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = chartData
        lineChart.isHidden = false
    }

}
