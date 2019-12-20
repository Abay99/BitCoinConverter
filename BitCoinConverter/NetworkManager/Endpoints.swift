//
//  Endpoints.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/15/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Alamofire

enum Endpoints: EndPointType {
    
    case getCurrencyRate(parameters: Parameters)
    case getTransactions
    case getChartData(parameters: Parameters)
    
    var baseURL: String {
        switch self {
        case .getCurrencyRate(_):
            return "https://api.coindesk.com/v1/bpi/"
        case .getTransactions:
            return "https://www.bitstamp.net/api/"
        case .getChartData(_):
            return "https://api.coindesk.com/v1/bpi/"
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .getCurrencyRate(let params):
            return .requestWithParameters(parameters: params)
        case .getChartData(let params):
            return .requestWithParameters(parameters: params)
        default:
            return .request
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getCurrencyRate(let params):
            let currency = String(describing: params["type"]!)
            return "currentprice/\(currency).json"
        case .getTransactions:
            return "transactions/"
        case .getChartData(let params):
            return "historical/close.json?currency=\(params["type"]!)&start=\(params["start_date"]!)&end=\(params["end_date"]!)"
        }
    }
}
