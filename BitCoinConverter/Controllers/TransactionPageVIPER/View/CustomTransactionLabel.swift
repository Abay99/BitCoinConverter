//
//  CustomTransactionLabel.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/20/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation
import UIKit

class CustomTransactionLabel: UILabel {
    
    init(title: String = "nil", size: CGFloat = 16, color: UIColor? = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) {
        super.init(frame: CGRect.zero)
        text = title
        textColor = color
        font = UIFont.boldSystemFont(ofSize: size)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

