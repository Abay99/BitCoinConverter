//
//  TransactionPageViewManager.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/18/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

class TransactionPageViewManager: NSObject, TransactionPageViewManaging {
    
    var selectedCellIndexPath: IndexPath?
    
    private enum LocalConstants {
        static let cellIdentifier: String = "TransactionPageCell"
        static let unselectedCellHeight: CGFloat = 80
        static let selectedCellHeight: CGFloat = 200
        static let cellWidthPadding: CGFloat = 12
        static let minimumLineSpacing: CGFloat = 1
    }
    
    var transactions: [TransactionData] = [] {
        didSet {
            customizedTableView.reloadData()
        }
    }
    
    lazy var customizedTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(TransactionCell.self, forCellReuseIdentifier: LocalConstants.cellIdentifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customizedTableView.dequeueReusableCell(withIdentifier: LocalConstants.cellIdentifier, for: indexPath) as! TransactionCell
        cell.update(with: transactions[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            return LocalConstants.selectedCellHeight
        }
        return LocalConstants.unselectedCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
            (customizedTableView.visibleCells[(indexPath.row)] as! TransactionCell).clickedView.isHidden = true
        } else {
            selectedCellIndexPath = indexPath
            
            for cell in self.customizedTableView.visibleCells {
                (cell as! TransactionCell).clickedView.isHidden = true
            }
            (customizedTableView.visibleCells[indexPath.row] as! TransactionCell).clickedView.isHidden = false
        }
        
        customizedTableView.beginUpdates()
        customizedTableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            tableView.scrollToRow(at: indexPath as IndexPath, at: .none, animated: true)
        }
    }
}
