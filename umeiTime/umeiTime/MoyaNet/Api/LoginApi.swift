//
//  LoginApi.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/22.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

enum LoginApi {
    case login(userId: String, pwd: String)
    case logout
    case otherLogin
    case bindUser
    case unBindUser
    case userInfo
    case userInfoList
}

extension LoginApi: NetTarget {

    var path: String {
        switch self {
        case .login:
            return ""
        default:
            return ""
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .login:
            return [:]
        default:
            return [:]
        }
    }
}
