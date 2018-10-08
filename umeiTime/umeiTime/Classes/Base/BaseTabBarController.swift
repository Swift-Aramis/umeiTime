//
//  BaseTabBarController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/4.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildController(vc: HomeListController(), title: "首页", normalImg: "tabbar_home_normal", selectedImg: "tabbar_home_selected")
        self.addChildController(vc: MurMurController(), title: "微语", normalImg: "tabbar_murmur_normal", selectedImg: "tabbar_murmur_selected")
        self.addChildController(vc: MessageController(), title: "消息", normalImg: "tabbar_msg_normal", selectedImg: "tabbar_msg_selected")
        self.addChildController(vc: MineController(), title: "我的", normalImg: "tabbar_mine_normal", selectedImg: "tabbar_mine_selected")

    }
    

    // 添加子控制器
    func addChildController(vc: UIViewController, title: String, normalImg: String, selectedImg: String)  {
        
        self.tabBarItem.title = title
        
        self.tabBar.tintColor = AppColor.tabbarNormalColor
        
        vc.title = title
        
        var norImg = UIImage(named: normalImg)
        norImg = norImg?.withRenderingMode(.alwaysOriginal)
        
        var selImg = UIImage(named:selectedImg as String)
        selImg = selImg?.withRenderingMode(.alwaysOriginal)

        let tabItem = UITabBarItem(title: title, image: norImg, selectedImage: selImg)
        
        let nav = BaseNavController.init(rootViewController: vc)
        
        nav.tabBarItem = tabItem
        
        self.addChild(nav)
    }

}
