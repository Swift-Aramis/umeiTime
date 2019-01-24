//
//  NetTarget.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/12/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import Moya

protocol NetTarget: Moya.TargetType {
    var parameters: [String : Any] { get }
}

extension NetTarget {
    var parameters: [String : Any] {
        return [:]
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var headers: [String: String]? {
        return ["AccessFrom": "IOS"]
    }
    
    var baseURL: URL {
        return NetConst.serverURL
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
}
