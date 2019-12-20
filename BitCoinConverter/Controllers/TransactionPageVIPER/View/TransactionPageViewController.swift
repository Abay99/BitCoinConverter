//
//  TransactionViewController.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/15/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

class TransactionPageViewController: UIViewController {
    
    //MARK: - UIComponents
    var output: TransactionPageViewOutput?
    var viewManager: TransactionPageViewManaging?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        setupViews()
    }
    
    private func setupViews() {
        title = "Transactions"
        view.backgroundColor = #colorLiteral(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        guard let tableView = viewManager?.customizedTableView else { return }
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
//MARK: TransactionPageViewInput methods

extension TransactionPageViewController: TransactionPageViewInput {
    func set(transactions: [TransactionData]) {
        viewManager?.transactions = transactions
    }
}
