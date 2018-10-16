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
        setupNavItem()
        setupContentView()
    }

}

extension HomeController {
    private func setupContentView() {
        let titles = ["文章", "图片"]
        let segmentView = SegmentView(frame: CGRect(x: 0, y: 0, width: 150, height: 44), segmentStyle: SegmentStyle(), titles: titles)
        self.navigationItem.titleView = segmentView
        
        let controllers = [HomeListController(type: .article),
                           HomeListController(type: .pic)]
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_search"), style: .plain, handler: { [weak self] in
            
            let searchNav = BaseNavController.init(rootViewController: HomeSearchController())
            self?.present(searchNav, animated: false, completion: nil)
        })
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_class"), style: .plain, handler: { [weak self] in
            
            self?.navigationController?.pushViewController(HomeClassController(), animated: true)
        })
    }
}
