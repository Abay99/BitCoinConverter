//
//  TransactionPagePresenter.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/18/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation

class TransactionPagePresenter: TransactionPageViewOutput, TransactionPageInteractorOutput {

    weak var view: TransactionPageViewInput?
    var interactor: TransactionPageInteractorInput?
    
    var transactions: [TransactionData] = []
    
    func viewIsReady() {
        interactor?.getTransactions()
    }
    
    func didLoad(transactions: [TransactionData]) {
        self.transactions = transactions
        view?.set(transactions: transactions)
    }
}
