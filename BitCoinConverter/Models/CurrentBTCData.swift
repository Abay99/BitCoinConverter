//
//  CurrentBTCData.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/17/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation

struct BPIResponse: Decodable {
    var bpi: CurrencyResponse?
}

struct CurrencyResponse: Decodable {
    var currency: CurrentBTCData?
    
    enum CodingKeys: String, CodingKey {
        case currency = "KZT"
    }
}

struct CurrentBTCData: Decodable {
    var rateFloat: Double?
    
    enum CodingKeys: String, CodingKey {
        case rateFloat = "rate_float"
    }
}

