//
//  TabBarItem.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/14/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import UIKit

final class TabBarItem: UITabBarItem {
    
    override var title: String? {
        get { return nil }
        set { super.title = newValue }
    }
    
    override var imageInsets: UIEdgeInsets {
        get { return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        set { super.imageInsets = newValue }
    }
    
    convenience init(image: UIImage?) {
        self.init()
        self.image = image
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
