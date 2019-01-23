//
//  LoginApi.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/22.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

enum UMRegType: Int {
    case QQ = 1, Weibo, Flyme, Wechat
}

enum LoginApi {
    case login(userId: String, pwd: String)
    case logout(uid: String)
    case otherLogin(userInfo: String)
    case bindUser(uid: String, openId: String, userId: String, regType: UMRegType)
    case unBindUser(uid: String, userId: String, regType: UMRegType)
    case userInfo(uid: String)
    case userInfoList(ids: String)
}

extension LoginApi: NetTarget {

    var path: String {
        switch self {
        case .login:
            return "login"
        case .logout:
            return "user/loginOut"
        case .otherLogin:
            return "otherLogin"
        case .bindUser:
            return "user/bindUser"
        case .unBindUser:
            return "user/unBindUser"
        case .userInfo:
            return "getUserInfoById"
        case .userInfoList:
            return "getUserInfoList"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .login(userId: let userId, pwd: let pwd):
            return ["userId": userId,
                    "pwd": pwd]
        case .logout(uid: let uid):
            return ["uid": uid]
        case .otherLogin(userInfo: let userInfo):
            return ["userInfo": userInfo]
        case .bindUser(uid: let uid,
                       openId: let openId,
                       userId: let userId,
                       regType: let regType):
            return ["uid": uid,
                    "openId": regType == .Wechat ? openId : "",
                    "userId": userId,
                    "regType": String(regType.rawValue)]
        case .unBindUser(uid: let uid,
                         userId: let userId,
                         regType: let regType):
            return ["uid": uid,
                    "userId": userId,
                    "regType": String(regType.rawValue)]
        case .userInfo(uid: let uid):
            return ["uid": uid]
        case .userInfoList(ids: let ids):
            return ["ids": ids]
        }
    }
}
