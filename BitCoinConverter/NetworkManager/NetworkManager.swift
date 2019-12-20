//
//  NetworkManager.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/15/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation
import Alamofire

class CurrencyRateNetworkManager {
    
    static func fetchCurrencyDate(for key: Currency, parameters: [String: String], resultCallback: @escaping (Result<CurrentBTCData>) -> Void) {
        let endPoint = Endpoints.getCurrencyRate(parameters: parameters)
        let urlString = (endPoint.baseURL + endPoint.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)!
        
        Alamofire.request(url, method: endPoint.httpMethod, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                guard
                    let json = data as? [String: Any],
                    let bpi = json["bpi"] as? [String: Any],
                    let currencyDate = bpi[key.rawValue] as? [String: Any] else { return }
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: currencyDate, options: [])
                    let result = try JSONDecoder().decode(CurrentBTCData.self, from: data)
                    resultCallback(.success(result))
                } catch {
                    resultCallback(.failure(error.localizedDescription))
                }
                    
            case .failure(let error):
                resultCallback(.failure(error.localizedDescription))
            }
        }

    }
}

class TransactionNetworkManager {
    
    static func fetchTransactionData(resultCallback: @escaping (Result<[TransactionData]>) -> Void) {
        let endPoint = Endpoints.getTransactions
        let urlString = (endPoint.baseURL + endPoint.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)!
        
        Alamofire.request(url, method: endPoint.httpMethod).responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [Any] else { return }
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                    let resultData = try JSONDecoder().decode([TransactionData].self, from: data)
                    resultCallback(.success(resultData))
                } catch {
                    resultCallback(.failure(error.localizedDescription))
                }
            case .failure(let error):
                resultCallback(.failure(error.localizedDescription))
            }
        }
    }
}

class LineChartNetworkManager {
    
    static func fetchChartDate(parameters: [String: String], resultCallback: @escaping (Result<NSDictionary>) -> Void) {
        let endPoint = Endpoints.getChartData(parameters: parameters)
        let urlString = (endPoint.baseURL + endPoint.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)!
        
        Alamofire.request(url, method: endPoint.httpMethod, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let json = data as? [String: Any], let bpi = json["bpi"] as? NSDictionary {
                    resultCallback(.success(bpi))
                }
            case .failure(let error):
                resultCallback(.failure(error.localizedDescription))
            }
        }
        
    }
}
