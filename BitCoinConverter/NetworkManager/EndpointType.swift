//
//  EndpointType.swift
//  BitCoinConverter
//
//  Created by Abai Kalikov on 12/15/19.
//  Copyright © 2019 Abai Kalikov. All rights reserved.
//

import Foundation
import Alamofire

public protocol EndPointType {
    var baseURL: String { get }
    var httpTask: HTTPTask { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var path: String { get }
}

public enum HTTPTask {
    case request
    case requestWithParameters(parameters: Parameters)
}

public enum Result<T> {
    case success(T)
    case failure(String)
}
