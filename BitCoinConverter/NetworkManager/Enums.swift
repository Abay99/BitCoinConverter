//
//  Enums.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/20/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation

enum Currency: String {
    case USD
    case EUR
    case KZT
    
    var description: String {
        switch self {
        case .USD:
            return "USD"
        case .EUR:
            return "EUR"
        default:
            return "KZT"
        }
    }
}

enum TimePeriod: String {
    case week
    case month
    case year
    
    var description: String {
        switch self {
        case .week:
            return "Неделя"
        case .month:
            return "Месяц"
        default:
            return "Год"
        }
    }
}
