//
//  NetWrapper.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/12/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import Moya

class NetWrapper: NSObject {
    static func provider<T: NetTarget>() -> MoyaProvider<T> {
        //FIXME: - 注意 plugins 调用顺序
        let provider = MoyaProvider<T>(plugins: [NetworkActivityPlugin(){_ ,_  in }])
        return provider
    }
}
