//
//  Test1ViewController.swift
//  RID
//
//  Created by Wewillapp03 on 9/13/2559 BE.
//  Copyright © 2559 Wewillapp. All rights reserved.
//

import UIKit
import Charts

class Test1ViewController: UIViewController {
    @IBOutlet weak var viewBarChart: BarChartView!
    private final let months = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var viewSearchYear: UIView!
    @IBOutlet weak var viewSearchDepartment: UIView!
    @IBOutlet weak var viewSearchAnnounce : UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initChart()
    }
    
    func initChart(){
        self.viewBarChart.delegate = self
        self.viewBarChart.drawBarShadowEnabled = false
        self.viewBarChart.drawValueAboveBarEnabled = true
        self.viewBarChart.maxVisibleValueCount = 60
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
        
        
        let rightAxis : ChartYAxis = viewBarChart.rightAxis
        rightAxis.enabled = true
        rightAxis.drawGridLinesEnabled = false
        rightAxis.labelFont = UIFont.systemFontOfSize(10.0)
        rightAxis.labelCount = 8
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinValue = 0.0
        
        self.viewBarChart.legend.position = .BelowChartLeft
        self.viewBarChart.legend.form = ChartLegend.Form.Square
        self.viewBarChart.legend.formSize = 9.0
        self.viewBarChart.legend.font = UIFont.systemFontOfSize(11.0)
        self.viewBarChart.legend.xEntrySpace = 1.0
        
        updateChartData()
    }
    
    func updateChartData(){
        let xValues : NSMutableArray! = NSMutableArray()
        let yValues1 : NSMutableArray! = NSMutableArray()
        let yValues2 : NSMutableArray! = NSMutableArray()
        
        for i in 0..<20{
            xValues.addObject(months[i % 12])
        }
        
        for i in 0..<50{
            var val : Int! = Int(arc4random_uniform(6)) + 1;
            yValues1.addObject(BarChartDataEntry(value: Double(val), xIndex: i))
        }
        
        //value 2
        for i in 0..<50{
            var val : Int! = Int(arc4random_uniform(6)) + 1;
            yValues2.addObject(BarChartDataEntry(value: Double(val), xIndex: i))
        }
        
        var set1 : BarChartDataSet! = nil
        if viewBarChart.data?.dataSetCount > 0 {
            set1 = viewBarChart.data?.dataSets[0] as! BarChartDataSet
            set1.yVals = yValues1 as! [ChartDataEntry]
            viewBarChart.data?.xValsObjc = xValues as! [NSObject]
            viewBarChart.data?.notifyDataChanged()
            viewBarChart.notifyDataSetChanged()
        }else{
            set1 = BarChartDataSet.init(yVals: yValues1 as! [ChartDataEntry], label: "DataSet")
            set1.barSpace = 0.35
            set1.setColor(ChartColorTemplates.material()[0])
            
            let dataSets : NSMutableArray! = NSMutableArray()
            dataSets.addObject(set1)
            let data : BarChartData! = BarChartData(xVals: xValues as! [NSObject], dataSets: dataSets as! [IChartDataSet])
            data.setValueFont(UIFont.systemFontOfSize(10.0))
            viewBarChart.data = data
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //        getDepartmentData()
    }
}

extension Test1ViewController : ChartViewDelegate{
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelected")
    }
}

