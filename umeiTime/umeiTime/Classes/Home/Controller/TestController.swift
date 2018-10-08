//
//  TestController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/4.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class TestController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        
        let scrollPageV = ScrollPageView(frame: CGRect(x: 0, y: 100, width: view.width, height: 300), segmentStyle: SegmentStyle(), titles: ["文章", "图片"], childControllers: [HomeArticleController(), HomePicController()], parentController: self)
        view.addSubview(scrollPageV)

    }
    

}
