//
//  CustomButton.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/16/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    init(title: String, size: CGFloat) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
