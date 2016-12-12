//
//  MultiBarController.swift
//  RID
//
//  Created by Wewillapp03 on 9/13/2559 BE.
//  Copyright © 2559 Wewillapp. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import Charts

class MultiBarController: UIViewController {
    @IBOutlet weak var viewBarChart: BarChartView!
    private final let months = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initChart()
    }
    
    func initChart(){
        self.viewBarChart.delegate = self
        self.viewBarChart.descriptionText = ""
        self.viewBarChart.noDataTextDescription = "จำนวนประกาศทางน้ำ"
        self.viewBarChart.pinchZoomEnabled = false
        self.viewBarChart.drawBarShadowEnabled = false
        self.viewBarChart.drawGridBackgroundEnabled = false
        
        let marker : ChartMarker! = ChartMarker()
        self.viewBarChart.marker = marker
        let legend : ChartLegend! = self.viewBarChart.legend
        legend.position = ChartLegend.Position.RightOfChartInside
        legend.font = UIFont.systemFontOfSize(10.0)
        
        
        let xAxis : ChartXAxis! = viewBarChart.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10.0)
        xAxis.drawGridLinesEnabled = false
        xAxis.spaceBetweenLabels = 0
        
        let leftAxis : ChartYAxis! = self.viewBarChart.leftAxis
        leftAxis.labelFont = UIFont.systemFontOfSize(10.0)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = NSNumberFormatter.init()
        leftAxis.valueFormatter?.maximumFractionDigits = 1
        leftAxis.valueFormatter?.negativeSuffix = " $"
        leftAxis.valueFormatter?.positiveSuffix = " $"
        leftAxis.labelPosition = .OutsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinValue = 0.0
        
        self.viewBarChart.rightAxis.enabled = false
        
        updateChartData()
    }
    
    func updateChartData(){
        let xValues : NSMutableArray! = NSMutableArray()
        
        
        for i in 0..<20{
            xValues.addObject(months[i % 12])
        }
        
        let yValues1 : NSMutableArray! = NSMutableArray()
        let yValues2 : NSMutableArray! = NSMutableArray()
        let yValues3 : NSMutableArray! = NSMutableArray()
        
        for i in 0..<50{
            var val : Int! = Int(arc4random_uniform(6)) + 1;
            yValues1.addObject(BarChartDataEntry(value: Double(val), xIndex: i))
            
            val = Int(arc4random_uniform(6)) + 1;
            yValues2.addObject(BarChartDataEntry(value: Double(val), xIndex: i))
            
            val = Int(arc4random_uniform(6)) + 1;
            yValues3.addObject(BarChartDataEntry(value: Double(val), xIndex: i))
        }
        
        var set1 : BarChartDataSet! = nil
        var set2 : BarChartDataSet! = nil
        var set3 : BarChartDataSet! = nil
        
        if viewBarChart.data?.dataSetCount > 0 {
            set1 = viewBarChart.data?.dataSets[0] as! BarChartDataSet
            set2 = viewBarChart.data?.dataSets[1] as! BarChartDataSet
            set3 = viewBarChart.data?.dataSets[2] as! BarChartDataSet
            set1.yVals = yValues1 as! [ChartDataEntry]
            set2.yVals = yValues2 as! [ChartDataEntry]
            set3.yVals = yValues3 as! [ChartDataEntry]
            viewBarChart.data?.xValsObjc = xValues as! [NSObject]
            viewBarChart.data?.notifyDataChanged()
            viewBarChart.notifyDataSetChanged()
        }else{
            set1 = BarChartDataSet.init(yVals: yValues1 as! [ChartDataEntry], label: "Data1")
            set1.setColor(UIColor.grayColor())
            set2 = BarChartDataSet.init(yVals: yValues1 as! [ChartDataEntry], label: "Data2")
            set2.setColor(UIColor.lightGrayColor())
            set3 = BarChartDataSet.init(yVals: yValues1 as! [ChartDataEntry], label: "Data3")
            set3.setColor(UIColor.darkGrayColor())
            //            set1.barSpace = 0.35
            
            let dataSets : NSMutableArray! = NSMutableArray()
            dataSets.addObject(set1)
            dataSets.addObject(set2)
            dataSets.addObject(set3)
            
            let data : BarChartData! = BarChartData(xVals: xValues as! [NSObject], dataSets: dataSets as! [IChartDataSet])
            data.groupSpace = 0.8
            data.setValueFont(UIFont.systemFontOfSize(10.0))
            viewBarChart.data = data
            
        }
        
    }
    
}

extension MultiBarController : ChartViewDelegate{
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelected")
    }
}

