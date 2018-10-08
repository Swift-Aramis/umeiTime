//
//  ScreenConst.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/27.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

//MARK: - ScreenConst
public let ScreenBounds = UIScreen.main.bounds
public let ScreenSize = ScreenBounds.size
public let ScreenWidth: CGFloat = ScreenSize.width
public let ScreenHeight: CGFloat = ScreenSize.height

//MARK: - ScaleFunc
public func scale(_ x: CGFloat) -> CGFloat {
    return ceil(x * ScreenWidth / 375.0)
}

//MARK: - Device
public let iPhoneX: Bool = ScreenHeight >= 812 ? true : false
public let iPhone6Plus: Bool = ScreenHeight == 736 ? true : false
public let iPhone6: Bool = ScreenHeight == 667 ? true : false
public let iPhone5: Bool = ScreenHeight <= 568 ? true : false

//MARK: - BarHeight
public let StatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
public let SafeAreaBottomInset: CGFloat = iPhoneX ? 34 : 0
public let NavBarHeight: CGFloat = StatusBarHeight + 44
public let TabBarHeight: CGFloat = SafeAreaBottomInset + 49


