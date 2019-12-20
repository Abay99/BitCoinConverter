//
//  TransactionPageAssembly.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/18/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation

class TransactionPageAssembly {
    func assembly() -> TransactionPageViewController {
        let viewController = TransactionPageViewController()
        let presenter = TransactionPagePresenter()
        let interactor = TransactionPageInteractor()
        let viewManager = TransactionPageViewManager()
        presenter.view = viewController
        viewController.viewManager = viewManager
        interactor.output = presenter
        presenter.interactor = interactor
        viewController.output = presenter
        return viewController
    }
}
