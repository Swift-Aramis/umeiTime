//
//  ScrollContentView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public typealias ContentScrollEnded = (_ index: Int) -> Void
public class ScrollContentView: UIView {

    public var contentScrollEnded: ContentScrollEnded?
    private var childControllers: [UIViewController]!
    private weak var parentController: UIViewController!
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.isPagingEnabled = true
        scrollV.bounces = false
        scrollV.showsHorizontalScrollIndicator = false
        return scrollV
    }()
    
    public init(frame: CGRect, childControllers: [UIViewController], parentController: UIViewController) {
        self.childControllers = childControllers
        self.parentController = parentController
       
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        parentController = nil
        print("\(self.debugDescription) --- 销毁")
    }
}

extension ScrollContentView: UIScrollViewDelegate {
    
    private func setup() {
        setupContentView()
        setupControllers()
    }
    
    private func setupControllers() {
        
        for (index, childController) in childControllers.enumerated() {
            if childController.isKind(of: UINavigationController.self) {
                fatalError("不要添加 UINavigationController 包装后的子控制器")
            }
            
            parentController.addChild(childController)
            scrollView.addSubview(childController.view)
            childController.view.size = scrollView.size
            childController.view.top = scrollView.top
            childController.view.left = CGFloat(index) * scrollView.width
        }
    }
    
    private func setupContentView() {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.parentController.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.addSubview(scrollView)
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(childControllers.count), height: scrollView.height)

        scrollView.delegate = self
        
        // 手势互斥
        if let nav = parentController.navigationController, let popGesture = nav.interactivePopGestureRecognizer {
            scrollView.panGestureRecognizer.require(toFail: popGesture)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("滚动减速")
        let currentIndex = Int(floor(scrollView.contentOffset.x / bounds.size.width))
        contentScrollEnded?(currentIndex)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentIndex = Int(floor(scrollView.contentOffset.x / bounds.size.width))
        if !decelerate {
            print("手动拖着结束")
            contentScrollEnded?(currentIndex)
        }
    }
    
}

//MARK: - Public Helper
extension ScrollContentView {
    // 切换到第几个页内容
    public func switchToContent(index: Int) {
        scrollView.setContentOffset(CGPoint(x: scrollView.width * CGFloat(index), y: 0), animated: true)
    }
}
