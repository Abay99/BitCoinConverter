//
//  CurrencyConverterViewController.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/15/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    var selectedIndex = 0
    var convertedRate: Double = 0
    var resultData = 0
    
    //MARK: - UIComponents
    
    lazy var segmentedController: UISegmentedControl = {
        let items = ["USD", "EUR", "KZT"]
        let segmentController = UISegmentedControl(items: items)
        segmentController.selectedSegmentIndex = 0
        segmentController.layer.cornerRadius = 10
        segmentController.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        segmentController.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentController.addTarget(self, action: #selector(segmentControllerPressed), for: .valueChanged)
        return segmentController
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bitCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC->$"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bitCoinTextField:UITextField = {
        let text = UITextField()
        text.placeholder = "BTC"
        text.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        text.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        text.keyboardType = .decimalPad
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 7
        text.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0)
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD->฿"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyTextField:UITextField = {
        let text = UITextField()
        text.placeholder = "$€₸"
        text.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        text.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 7
        text.keyboardType = .decimalPad
        text.layer.sublayerTransform = CATransform3DMakeTranslation(10, 2, 0)
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var converterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(converterButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Life cycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchData(for: .USD, parameters: ["type": Currency.USD.description]) { [weak self] result in
            self?.convertedRate = result
        }
    }
    
    @objc func segmentControllerPressed() {
        let bitCoinToCurrency = ["BTC->$", "BTC->€", "BTC->₸"]
        let currencyToBitCoin = ["USD->฿","EUR->฿","KZT->฿"]
        
        switch segmentedController.selectedSegmentIndex {
        case 0:
            selectedIndex = 0
            segmentPressedSteps(key: .USD, selectedIndex: selectedIndex, currency: Currency.USD.description, bitCoinToCurrency: bitCoinToCurrency, currencyToBitCoin: currencyToBitCoin)
        case 1:
            selectedIndex = 1
            segmentPressedSteps(key: .EUR, selectedIndex: selectedIndex, currency: Currency.EUR.description, bitCoinToCurrency: bitCoinToCurrency, currencyToBitCoin: currencyToBitCoin)
        default:
            selectedIndex = 2
            segmentPressedSteps(key: .KZT, selectedIndex: selectedIndex, currency: Currency.KZT.description, bitCoinToCurrency: bitCoinToCurrency, currencyToBitCoin: currencyToBitCoin)
        }
    }
    
    @objc func converterButtonPressed() {
        let symbol = [" $"," €"," ₸"]
        
        if currencyTextField.text!.count > 0{
            let money = (currencyTextField.text! as NSString).doubleValue
            resultLabel.text = String((money/convertedRate)) + " BCT"
        }
        if bitCoinTextField.text!.count > 0{
            let money = (bitCoinTextField.text! as NSString).doubleValue
            resultLabel.text = String(money*convertedRate) + symbol[selectedIndex]
        }
        if (bitCoinTextField.text!.count == 0 && currencyTextField.text!.count == 0){
            resultLabel.text = "Nothing to convert"
        }
    }
    
    //MARK: - Fetching currency data
    
    func fetchData(for key: Currency, parameters: [String: String], resultCallback: @escaping (Double) -> Void) {
        CurrencyRateNetworkManager.fetchCurrencyDate(for: key, parameters: parameters) { result in
            switch result {
            case .success(let response):
                if let rate = response.rateFloat {
                    resultCallback(rate)
                }
            case .failure(let errorDescription):
                print(errorDescription)
            }
        }
    }
    
    func segmentPressedSteps(key: Currency, selectedIndex: Int, currency: String, bitCoinToCurrency: [String], currencyToBitCoin: [String]) {
        bitCoinLabel.text = bitCoinToCurrency[selectedIndex]
        currencyLabel.text = currencyToBitCoin[selectedIndex]
        fetchData(for: key, parameters: ["type": currency]) { [weak self] result in
            self?.convertedRate = result
        }
    }
}

//MARK: - Setup methods

private extension CurrencyConverterViewController {
    
    func setupViews() {
        title = "Currency Converter"
        view.backgroundColor = #colorLiteral(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        [segmentedController, containerView].forEach { (views) in
            view.addSubview(views)
        }
        [bitCoinLabel, bitCoinTextField, currencyLabel, currencyTextField, converterButton, resultLabel].forEach { (views) in
            containerView.addSubview(views)
        }
    }
    
    func setupConstraints() {
        segmentedController.snp.makeConstraints {
            $0.top.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(segmentedController.snp.bottom).offset(30)
            $0.width.equalTo(segmentedController.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.centerX.equalToSuperview()
        }
        
        bitCoinLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(20)
        }
        
        bitCoinTextField.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(bitCoinLabel.snp.right).offset(10)
            $0.right.equalTo(-20)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(30)
            $0.centerY.equalTo(bitCoinLabel.snp.centerY)
        }
        
        currencyLabel.snp.makeConstraints {
            $0.top.equalTo(bitCoinLabel.snp.bottom).offset(20)
            $0.left.equalTo(20)
        }
        
        currencyTextField.snp.makeConstraints {
            $0.top.equalTo(bitCoinLabel.snp.bottom).offset(20)
            $0.left.equalTo(currencyLabel.snp.right).offset(10)
            $0.right.equalTo(-20)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(30)
            $0.centerY.equalTo(currencyLabel.snp.centerY)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(currencyTextField.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    
        converterButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.centerX.equalToSuperview()
        }
    }
}
