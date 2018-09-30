//
//  HomeController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomeController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightNavItem()
    }
    
    private func setupRightNavItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_search"), style: .plain, handler: { 
        })
    }


}
