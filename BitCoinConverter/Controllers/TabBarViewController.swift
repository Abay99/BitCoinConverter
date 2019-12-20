//
//  TabBarViewController.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/14/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTab()
        setupTabBar()
    }
    
    private func makeTab() {
        viewControllers = tap()
    }
    
    private func tap() -> [UINavigationController] {
        
        //ExchangeRate viewController
        let exchangeRateViewController = ExchangeRateViewController()
        exchangeRateViewController.tabBarItem = TabBarItem(image: #imageLiteral(resourceName: "home"))
        let exchangeRateNavigationController = UINavigationController(rootViewController: exchangeRateViewController)
        
        //TransactionList viewController
        let transactionPageViewController = TransactionPageAssembly().assembly()
        transactionPageViewController.tabBarItem = TabBarItem(image: #imageLiteral(resourceName: "history"))
        let transactionListNavigationController = UINavigationController(rootViewController: transactionPageViewController)
        
        //CurrencyConverter viewcontroller
        let currencyConverterViewController = CurrencyConverterViewController()
        currencyConverterViewController.tabBarItem = TabBarItem(image: #imageLiteral(resourceName: "calculator"))
        let currencyConverterNavigationController = UINavigationController(rootViewController: currencyConverterViewController)
        
        //TabBar controllers
        let controllers = [
            exchangeRateNavigationController,
            transactionListNavigationController,
            currencyConverterNavigationController
        ]
        
        return controllers
    }
    
    //MARK: - Setup TabBar method
    
    private func setupTabBar() {
        tabBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.tintColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 10
        selectedIndex = 0
    }
}
