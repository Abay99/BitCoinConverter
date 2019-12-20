//
//  TransactionCell.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/18/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    //MARK: - UIComponents
    
    lazy var typeLabel: UILabel = {
        let label = CustomTransactionLabel(size: 18, color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        return label
    }()
    
    lazy var dateLabel :UILabel = {
        let label = CustomTransactionLabel(title: "Дата:")
        return label
    }()
    
    lazy var dateTitle: UILabel = {
        let label = CustomTransactionLabel(size: 16)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = CustomTransactionLabel(title: "Время:")
        return label
    }()
    
    lazy var timeTitle : UILabel = {
        let label = CustomTransactionLabel()
        return label
    }()

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    lazy var timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    lazy var clickedView: UIView = {
        let view = UIView()
        view.isHidden  = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let label = CustomTransactionLabel(title: "Количество:", size: 16)
        return label
    }()
    
    lazy var amountTitle: UILabel = {
        let label = CustomTransactionLabel(size: 16)
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = CustomTransactionLabel(title: "ID:", size: 16)
        return label
    }()
    
    lazy var idTitle: UILabel = {
        let label = CustomTransactionLabel(size: 16)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = CustomTransactionLabel(title: "Стоимость:", size: 16)
        return label
    }()
    
    lazy var priceTitle: UILabel = {
        let label = CustomTransactionLabel(size: 16)
        return label
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let label = CustomTransactionLabel(title: "Тотал:", size: 16)
        return label
    }()
    
    lazy var totalPriceTitle: UILabel = {
        let label = CustomTransactionLabel(size: 16)
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: TransactionData) {
        DispatchQueue.main.async {
            if let type = model.type, let date = model.date, let amount = model.amount, let id = model.transactionID, let price = model.price {
            self.typeLabel.text = (type == 0) ? "Продажа" : "Покупка"
            let modelDate = Date.init(timeIntervalSince1970: TimeInterval(Double(String(describing: date))!))
            self.dateTitle.text = self.dateFormatter.string(from: modelDate)
            self.timeTitle.text = self.timeFormatter.string(from: modelDate)
            self.amountTitle.text = amount
            self.idTitle.text = String(describing: id)
            self.priceTitle.text = model.price
            let total = Double("\(amount)")! * Double("\(price)")!
            self.totalPriceTitle.text = "\(total) $"
            }
        }
    }
}

//MARK: - Setup methods

private extension TransactionCell {
    
    func setupViews() {
        backgroundColor = #colorLiteral(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        [typeLabel, timeLabel, timeTitle, dateLabel, dateTitle, clickedView].forEach { (views) in
            addSubview(views)
        }
        [amountLabel, amountTitle, idLabel, idTitle, priceLabel, priceTitle, totalPriceLabel, totalPriceTitle].forEach { (views) in
            clickedView.addSubview(views)
        }
    }
    
    func setupConstraints() {
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(10)
            $0.left.equalTo(20)
            $0.height.equalTo(20)
        }
        
        dateTitle.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(10)
            $0.left.equalTo(dateLabel.snp.right).offset(5)
            $0.height.equalTo(20)
        }

        timeTitle.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(10)
            $0.right.equalTo(-20)
            $0.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(10)
            $0.right.equalTo(timeTitle.snp.left).offset(-5)
            $0.height.equalTo(20)
        }
        
        clickedView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.width.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(clickedView.snp.top)
            $0.left.equalTo(dateLabel.snp.left)
            $0.height.equalTo(20)
        }
        
        priceTitle.snp.makeConstraints {
            $0.top.equalTo(clickedView.snp.top)
            $0.left.equalTo(priceLabel.snp.right).offset(5)
            $0.height.equalTo(20)
        }
        
        amountLabel.snp.makeConstraints {
            $0.top.equalTo(priceTitle.snp.top).offset(25)
            $0.left.equalTo(dateLabel.snp.left)
            $0.height.equalTo(20)
        }
        
        amountTitle.snp.makeConstraints {
            $0.top.equalTo(priceTitle.snp.top).offset(25)
            $0.left.equalTo(amountLabel.snp.right).offset(5)
            $0.height.equalTo(20)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.top.equalTo(amountTitle.snp.top).offset(25)
            $0.left.equalTo(dateLabel.snp.left)
            $0.height.equalTo(20)
        }
        
        totalPriceTitle.snp.makeConstraints {
            $0.top.equalTo(amountTitle.snp.top).offset(25)
            $0.left.equalTo(totalPriceLabel.snp.right).offset(5)
            $0.height.equalTo(20)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(totalPriceTitle.snp.top).offset(25)
            $0.left.equalTo(dateLabel.snp.left)
            $0.height.equalTo(20)
        }
        
        idTitle.snp.makeConstraints {
            $0.top.equalTo(totalPriceTitle.snp.top).offset(25)
            $0.left.equalTo(idLabel.snp.right).offset(5)
            $0.height.equalTo(20)
        }
    }
}
