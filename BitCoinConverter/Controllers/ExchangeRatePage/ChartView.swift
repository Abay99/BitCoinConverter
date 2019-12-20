//
//  ChartView.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/20/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit
import Charts

class ChartView: UIView {
    
    var currencyData = "USD"
    var intervalCurrencyPrice: [Double] = []
    var chartIndex = 0
    
    //MARK: - UIComponents
    
    lazy var chartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    lazy var weekButton: UIButton = {
        let button = CustomButton(title: TimePeriod.week.description, size: 16)
        button.addTarget(self, action: #selector(weekButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var monthButton: UIButton = {
        let button = CustomButton(title: TimePeriod.month.description, size: 16)
        button.addTarget(self, action: #selector(monthButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var yearButton: UIButton = {
        let button = CustomButton(title: TimePeriod.year.description, size: 16)
        button.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weekButton, monthButton, yearButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        changeButtonColor(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), buttons: [weekButton, monthButton, yearButton])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func weekButtonPressed() {
        changeButtonColor(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), buttons: [weekButton, monthButton, yearButton])
        let dateInterval = Calendar.current.date(byAdding: .day, value: -8, to: Date())!
        buttonPressedSteps(chartIndex: 0, dateInterval: dateInterval)
    }
    
    @objc func monthButtonPressed() {
        changeButtonColor(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), buttons: [monthButton, weekButton, yearButton])
        let dateInterval = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        buttonPressedSteps(chartIndex: 1, dateInterval: dateInterval)
    }
    
    @objc func yearButtonPressed() {
        let dateInterval = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        changeButtonColor(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), buttons: [yearButton, monthButton, weekButton])
        buttonPressedSteps(chartIndex: 2, dateInterval: dateInterval)
    }
    
    func buttonPressedSteps(chartIndex: Int, dateInterval: Date) {
        self.chartIndex = chartIndex
        intervalCurrencyPrice.removeAll()
        let date = getDate(date: dateInterval)
        let currentDate = getDate(date: Date())
        let parameters = ["type": currencyData, "start_date": date, "end_date": currentDate]
        fetchChartData(parameters: parameters)
    }

    func changeButtonColor(color: UIColor, buttons: [UIButton]) {
        buttons.enumerated().forEach { index, button in
            switch index {
            case 0 :
                button.setTitleColor(color, for: .normal)
            default:
                button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
            }
        }
    }
    
    //MARK: - Fetching Chart Data
    
    func fetchChartData(parameters: [String: String]) {
        
        LineChartNetworkManager.fetchChartDate(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let lastPrices = response.allValues as? [Double] {
                    for lastPrice in lastPrices{
                        self.intervalCurrencyPrice.append(lastPrice)
                    }
                    self.updateChart()
                }
                
            case .failure(let errorDescription):
                print(errorDescription)
            }
        }
    }
    
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    
    func fullChart(from: Int, to: Int, by: Int) -> [ChartDataEntry] {
        var counter = 1
        var lineChartEntry: [ChartDataEntry] = []
        let list = stride(from: from, to: to, by: by)
        
        list.forEach { index in
            let value = ChartDataEntry(x: Double(counter), y: intervalCurrencyPrice[index])
            lineChartEntry.append(value)
            counter += 1
        }
        return lineChartEntry
    }
    
    // MARK: - Update chart
    
    func updateChart() {
        let line = LineChartDataSet(entries: getLineChartEntryList(), label: "Rate")
        line.colors = [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
        line.circleColors = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)]
        
        let data = LineChartData()
        data.addDataSet(line)
        chartView.data = data
        chartView.chartDescription?.text = "BitCoin Charts"
    }
    
    func getLineChartEntryList() -> [ChartDataEntry] {
        var lineChartEntry : [ChartDataEntry] = []
        
        switch chartIndex {
        case 0:
            lineChartEntry = fullChart(from: 0, to: 7, by: 1)
        case 1:
            lineChartEntry = fullChart(from: 7, to: 30, by: 7)
        default:
            lineChartEntry = fullChart(from: 0, to: 365, by: 31)
        }
        return lineChartEntry
    }
}

//MARK: - Setup methods

private extension ChartView {
    
    func setupViews() {
        [chartView, timeStackView].forEach { (views) in
            addSubview(views)
        }
    }
    
    func setupConstraints() {
        chartView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        
        timeStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(chartView.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.55)
        }
    }
}
