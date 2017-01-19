//
//  PieChartHeaderView.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit
import Charts

class PieChartHeaderView: UIView, ChartViewDelegate {
    
    var timeFrameChangedDelegate: TimeFrameChangeDelegate?
    var transactionTypeChangeDelegate: TransactionTypeChangedDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var monthButton: TimeFrameButton!
    @IBOutlet weak var biannualButton: TimeFrameButton!
    @IBOutlet weak var yearButton: TimeFrameButton!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var innerPieChartView: PieChartView!

    var outerPieChartValue = [(Double, UIColor)]() {
        willSet(newValue) {
            setChart(self.pieChartView, values: newValue)
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PieChartHeaderView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
        
        self.monthButton.isSelected = true
        
        self.setupPieChartView(chartView: self.pieChartView)
        self.setupPieChartView(chartView: self.innerPieChartView)
        
        let innerValues = [(50.0, Constants.Colors.purple), (50.0, Constants.Colors.orange)]
        setChart( self.innerPieChartView, values: innerValues, sliceSpace: 5)
        
        let outerValues = [(0.0, UIColor.clear)]
        setChart( self.pieChartView, values: outerValues)
    }
    
    func setupPieChartView(chartView: PieChartView) {
        chartView.legend.enabled = false
        chartView.chartDescription?.text = ""
        chartView.delegate = self
        chartView.rotate(-45)
        chartView.transparentCircleColor = UIColor.clear
    }
    
    // MARK: Action
    
    @IBAction func monthButtonClicked(_ sender: Any) {
        deselectAll()
        (sender as! UIButton).isSelected = true
        if self.timeFrameChangedDelegate != nil {
            self.timeFrameChangedDelegate!.monthSelected()
        }
    }
    
    @IBAction func biannualButtonClicked(_ sender: Any) {
        deselectAll()
        (sender as! UIButton).isSelected = true
        if self.timeFrameChangedDelegate != nil {
            self.timeFrameChangedDelegate!.biannualSelected()
        }
    }
    
    @IBAction func yearButtonClicked(_ sender: Any) {
        deselectAll()
        (sender as! UIButton).isSelected = true
        if self.timeFrameChangedDelegate != nil {
            self.timeFrameChangedDelegate!.yearSelected()
        }
    }

    
    func setChart(_ chartView: PieChartView, values: [(Double, UIColor)], sliceSpace: Float = 0) {
        var dataEntries: [ChartDataEntry] = []
        var colors: [UIColor] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i].0)
            dataEntries.append(dataEntry)
            colors.append(values[i].1)
        }

        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "nada")
        pieChartDataSet.colors = colors
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.selectionShift = 0
        pieChartDataSet.sliceSpace = CGFloat(sliceSpace)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        chartView.data = pieChartData
    }
    
    func deselectAll() {
        for view in buttonContainerView.subviews {
            (view as! UIButton).isSelected = false
        }
    }
    
    // MARK: Chart View Delegate
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if chartView == self.innerPieChartView {
            if self.transactionTypeChangeDelegate != nil {
                if entry.x == 0 {
                    self.transactionTypeChangeDelegate?.refundTypeSelected()
                }else {
                    self.transactionTypeChangeDelegate?.purchacesTypeSelected()
                }
            }
            
        }
    }
    
    
    
}
