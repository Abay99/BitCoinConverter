//
//  ExchangeRateViewController.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/15/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

protocol CurrencyDelegate {
    func getCurrency(currency: String)
}

class ExchangeRateViewController: UIViewController {
    
    var transactionList: [TransactionData] = []
    var currentCurrency = "USD"
    
    //MARK: - UIComponents
    
    lazy var bitCoinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var bitCoinPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    lazy var usdButton: UIButton = {
        let button = CustomButton(title: Currency.USD.description, size: 20)
        button.addTarget(self, action: #selector(usdButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var eurButton: UIButton = {
        let button = CustomButton(title: Currency.EUR.description, size: 20)
        button.addTarget(self, action: #selector(eurButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var kztButton: UIButton = {
        let button = CustomButton(title: Currency.KZT.description, size: 20)
        button.addTarget(self, action: #selector(kztButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var currencyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usdButton, eurButton, kztButton])
        stackView.axis = .horizontal
        stackView.spacing = 0.2
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var chartView: ChartView = {
        let chart = ChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawLine()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrencyData(for: .USD, parameters: ["type": Currency.USD.description])
        changeButtonColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), buttons: [usdButton, kztButton, eurButton])
    }
    
    @objc func usdButtonPressed() {
        changeButtonColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), buttons: [usdButton, kztButton, eurButton])
        currentCurrency = Currency.USD.description
        fetchCurrencyData(for: .USD, parameters: ["type": currentCurrency])
    }
    
    @objc func eurButtonPressed() {
        changeButtonColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), buttons: [eurButton, usdButton, kztButton])
        currentCurrency = Currency.EUR.description
        fetchCurrencyData(for: .EUR, parameters: ["type": currentCurrency])
    }
    
    @objc func kztButtonPressed() {
        changeButtonColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), buttons: [kztButton, usdButton, eurButton])
        currentCurrency = Currency.KZT.description
        fetchCurrencyData(for: .KZT, parameters: ["type": currentCurrency])
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
    
    func drawLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 120))
        path.addLine(to: CGPoint(x: view.frame.width - 20, y: 120))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7)
        shapeLayer.lineWidth = 1
        
        view.layer.addSublayer(shapeLayer)
    }
    
    //MARK: - Fetching Currenct Data
    
    func fetchCurrencyData(for key: Currency, parameters: [String: String]) {
        
        CurrencyRateNetworkManager.fetchCurrencyDate(for: key, parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let rate = response.rateFloat {
                    self.bitCoinPriceLabel.text = "\(String(describing: rate))"
                }
            case .failure(let errorDescription):
                print(errorDescription)
            }
        }
    }
}
    
private extension ExchangeRateViewController{
    
    func setupViews() {
        title = "Exchange Rate"
        view.backgroundColor = #colorLiteral(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        [bitCoinNameLabel, bitCoinPriceLabel, currencyStackView, chartView].forEach { (views) in
            view.addSubview(views)
        }
    }
    
    func setupConstraints() {
        
        bitCoinNameLabel.snp.makeConstraints {
            $0.top.equalTo(80)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        
        bitCoinPriceLabel.snp.makeConstraints {
            $0.top.equalTo(90)
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
        }
        
        currencyStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bitCoinNameLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        chartView.snp.makeConstraints {
            $0.top.equalTo(currencyStackView.snp.bottom).offset(20)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
    }
}
