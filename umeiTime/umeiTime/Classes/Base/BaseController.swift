//
//  BaseController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/27.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import FNMatchPull
import ESPullToRefresh

class BaseController: UIViewController {
    
    let refreshAnimator: FNMatchPullAnimator = {
        let matchAnimator = FNMatchPullAnimator(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 80))
        matchAnimator.text = "UME"
        matchAnimator.style = .text
        matchAnimator.lineWidth = 1.5
        return matchAnimator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    deinit {
        print("\(self.debugDescription) --- 销毁")
    }
}
