//
//  TransactionPageInteractor.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/18/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

class TransactionPageInteractor: TransactionPageInteractorInput {
    
    weak var output: TransactionPageInteractorOutput?
    
    func getTransactions() {
        TransactionNetworkManager.fetchTransactionData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.output?.didLoad(transactions: response)
                print("Transaction \(response[0])")
            case .failure(let errorDescription):
                print(errorDescription)
            }
        }
    }
}
