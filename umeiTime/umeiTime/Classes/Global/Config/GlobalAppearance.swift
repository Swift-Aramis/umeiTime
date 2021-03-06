//
//  GlobalAppearance.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class GlobalAppearance: NSObject {

    static func setupUIAppearance() {
        setupNavBarAppearance()
        setupTableViewAppearance()
        setupHUD()
    }
    
    private class func setupNavBarAppearance() {
        /// title颜色 Attributes 可以包含字体颜色和大小以及字体样式【中间Title字体】
        UINavigationBar.appearance().titleTextAttributes = [
            .font: AppFont.titleBoldFont,
            .foregroundColor: AppColor.darkBlack
        ]
        
        /// left、right-item color【左右item的颜色】
        UINavigationBar.appearance().tintColor = AppColor.darkBlack
        
        /// NavigationBar backgroundcolor【背景色】
        UINavigationBar.appearance().barTintColor = UIColor.white
        /// NavigationBar【背景图】
//        UINavigationBar.appearance().setBackgroundImage(UIImage(color: UIColor.white, size: CGSize(width: 1, height: 1)), for: .default)
        /// TabBar【背景图】
//        UITabBar.appearance().backgroundImage = UIImage(color: UIColor.white, size: CGSize(width: 1, height: 1))

        /// UIBarButtonItem【字体色、字体大小】
        let barButtonAttributes: [NSAttributedString.Key : Any] = [
            .font: AppFont.titleFont,
            .foregroundColor:  AppColor.darkBlack
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributes, for: .highlighted)
    }
    
    private class func setupTableViewAppearance() {
        
    }
    
    private class func setupHUD() {
        HUD.setMaskStyle(.hide)
        HUD.setAnimationShowStyle(.fade)
    }
}
