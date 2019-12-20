//
//  TransactionData.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/17/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation

struct TransactionData: Decodable {
    let date: String?
    let transactionID: Int?
    let price: String?
    let type: Int?
    let amount: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case transactionID = "tid"
        case price
        case type
        case amount
    }
}
