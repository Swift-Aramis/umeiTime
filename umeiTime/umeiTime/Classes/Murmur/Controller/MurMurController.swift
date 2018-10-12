//
//  MurMurController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MurMurController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItem()
        setupContentView()
    }

}

extension MurMurController {
    
    private func setupContentView() {
        let titles = ["推荐", "小组", "关注"]
        let segmentView = SegmentView(frame: CGRect(x: 0, y: 0, width: 150, height: 44), segmentStyle: SegmentStyle(), titles: titles)
        self.navigationItem.titleView = segmentView
        
        let controllers = [MListController(),
                           MGroupController(),
                           MListController()]
        let scrollContentView = ScrollContentView(frame: CGRect(x: 0, y: NavBarHeight, width: view.width, height: view.height - NavBarHeight - TabBarHeight), childControllers: controllers, parentController: self)
        view.addSubview(scrollContentView)
        
        segmentView.titleButtonOnClicked = { (text, index) in
            scrollContentView.switchToContent(index: index)
        }
        
        scrollContentView.contentScrollEnded = { (index) in
            segmentView.switchToTitle(index: index)
        }
    }
    
    private func setupNavItem() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_class"), style: .plain, handler: { [weak self] in
            
            let murmurEditVC = MEditController(style: .grouped)
            self?.navigationController?.pushViewController(murmurEditVC, animated: true)
        })
    }
}
