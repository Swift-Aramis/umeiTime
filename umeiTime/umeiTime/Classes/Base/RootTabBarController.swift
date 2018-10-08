//
//  RootTabBarController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class RootTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBarItems: [ESTabBarItem]!
        tabBarItems = [
            ESTabBarItem(TabBarBouncesContentView(), title: "首页", image: R.image.tabbar_home_normal(), selectedImage: R.image.tabbar_home_selected()),
            ESTabBarItem(TabBarBouncesContentView(), title: "微语", image: R.image.tabbar_murmur_normal(), selectedImage: R.image.tabbar_murmur_selected()),
            ESTabBarItem(TabBarBouncesContentView(), title: "消息", image: R.image.tabbar_msg_normal(), selectedImage: R.image.tabbar_msg_selected()),
            ESTabBarItem(TabBarBouncesContentView(), title: "我的", image: R.image.tabbar_mine_normal(), selectedImage: R.image.tabbar_mine_selected())
        ]

        let controllers = [HomeController(),
                           MurMurController(),
                           MessageController(),
                           MineController()
        ]
        for (i, viewController) in controllers.enumerated() {
            viewController.tabBarItem = tabBarItems[i]
        }

        self.viewControllers = controllers.map({ (viewController) in
            return BaseNavController(rootViewController: viewController)
        })
        
    }
}

class TabBarBasicContentView: ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = AppColor.tabbarNormalColor
        highlightTextColor = AppColor.tabbarSelectedColor
        iconColor = AppColor.tabbarNormalColor
        highlightIconColor = AppColor.tabbarSelectedColor
        renderingMode = .alwaysOriginal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TabBarBouncesContentView: TabBarBasicContentView {
    
    var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = .cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}
