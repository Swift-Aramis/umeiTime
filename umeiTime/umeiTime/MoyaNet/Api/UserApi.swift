//
//  UserApi.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/23.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

enum UserApi {
    case checkUserState(token: String)
    case userInfo(uid: Int, userId: Int)
}

extension UserApi: NetTarget {
    
    var path: String {
        switch self {
        case .checkUserState:
            return "checkUserState"
        case .userInfo:
            return "getUserInfo"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .checkUserState(token: let token):
            return ["token": token]
        case .userInfo(uid: let uid, userId: let userId):
            return ["uid": uid, "userId": userId]
        }
        
    }
}
