//
//  HomeController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomeController: BaseController {
    
    var listType: HomeListType = .article
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItem()
        setupContentView()
    }

}

extension HomeController {
    private func setupContentView() {
        let controllers = [HomeListController(type: .article),
                           HomeListController(type: .pic)]
        let scrollContentViewFrame = CGRect(x: 0, y: NavBarHeight, width: view.width, height: view.height - NavBarHeight - TabBarHeight)
        let scrollContentView = ScrollContentView(frame: scrollContentViewFrame, childControllers: controllers, parentController: self)
        view.addSubview(scrollContentView)
        
        let titles = ["文章", "图片"]
        let segmentView = SegmentView(frame: CGRect(x: 0, y: 0, width: 150, height: 44), segmentStyle: SegmentStyle(), titles: titles, scrollContentView: scrollContentView)
        self.navigationItem.titleView = segmentView
        
        segmentView.titleButtonOnClicked = { [weak self] (text, index) in
            self?.listType = HomeListType(rawValue: index) ?? .article
        }
        
        scrollContentView.contentScrollEnded = { [weak self] (index) in
            segmentView.switchToTitle(index: index)
            self?.listType = HomeListType(rawValue: index) ?? .article
        }
    }
    
    private func setupNavItem() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_search"), style: .plain, handler: { [weak self] in
            
            let searchNav = BaseNavController.init(rootViewController: HomeSearchController())
            self?.present(searchNav, animated: false, completion: nil)
        })
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_class"), style: .plain, handler: { [weak self] in
            
            var articleType: UMArticleType = .article
            if self?.listType == .pic {
                articleType = .picture
            }
            let classVC = HomeClassController(type: articleType)
            self?.navigationController?.pushViewController(classVC, animated: true)
        })
    }
}
