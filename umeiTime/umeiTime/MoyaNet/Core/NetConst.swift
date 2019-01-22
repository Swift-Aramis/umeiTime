//
//  NetConst.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/12/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import Moya

struct NetConst {
    static let serverURL = URL(string: "http://test.umeitime.com/umei")!
}

public enum NetError: Swift.Error, LocalizedError {
    
}
