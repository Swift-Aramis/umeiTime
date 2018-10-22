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
        let controllers = [MGroupController(),
                           MListController(style: .grouped),
                           MListController(style: .grouped)]
        let scrollContentViewFrame = CGRect(x: 0, y: NavBarHeight, width: view.width, height: view.height - NavBarHeight - TabBarHeight)
        let scrollContentView = ScrollContentView(frame: scrollContentViewFrame,
                                                  childControllers: controllers,
                                                  parentController: self)
        
        let titles = ["小组", "推荐", "关注"]
        var segmentStyle = SegmentStyle()
        segmentStyle.selectedIndex = 1
        
        let segmentViewFrame =  CGRect(x: 0, y: 0, width: 150, height: 44)
        let segmentView = SegmentView(frame: segmentViewFrame, segmentStyle: segmentStyle, titles: titles, scrollContentView: scrollContentView)
        self.navigationItem.titleView = segmentView
        
        view.addSubview(scrollContentView)
        
        scrollContentView.contentScrollEnded = { (index) in
            segmentView.switchToTitle(index: index)
        }
    }
    
    private func setupNavItem() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_issue_green")?.withRenderingMode(.alwaysOriginal), style: .plain, handler: { [weak self] in
            
            let murmurEditVC = MEditController(style: .grouped)
            self?.navigationController?.pushViewController(murmurEditVC, animated: true)
        })
    }
}
