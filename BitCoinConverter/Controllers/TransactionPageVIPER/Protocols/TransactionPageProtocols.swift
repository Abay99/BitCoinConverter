//
//  TransactionPageProtocols.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/18/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

protocol TransactionPageViewManaging: UITableViewDelegate,UITableViewDataSource {
    var customizedTableView: UITableView { get }
    var transactions: [TransactionData] { get set }
}

protocol TransactionPageViewInput: class {
    func set(transactions: [TransactionData])
}

protocol TransactionPageViewOutput {
    func viewIsReady()
}

protocol TransactionPageInteractorInput {
    func getTransactions()
}

protocol TransactionPageInteractorOutput: class {
    func didLoad(transactions: [TransactionData])
}
