//
//  RandomNumber.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/30.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

class RandomNumber: NSObject {

    // 获取一个随机数范围在：[500,1000），包括500，不包括1000
    static var lookNum: Int {
        return Int((arc4random() % 501) + 500)
    }
}
