//
//  BaseNavController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/27.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        /** 启用滑动返回（swipe back）*/
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK: - Private
    
    /// 是否允许手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
            //只有二级及以上的页面允许手势返回
            return self.viewControllers.count > 1
        }
        return true
    }
    
    /// 拦截 push 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.nav_icon_back(), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回上一控制器
    @objc private func navigationBack() {
        popViewController(animated: true)
    }
    

}
