//
//  ScrollPageView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class ScrollPageView: UIView {

    public var segmentStyle: SegmentStyle!
    public var segmentTitles: [String]!
    
    private var childControllers: [UIViewController]!
    private weak var parentController: UIViewController!
    
    private(set) var segmentView: SegmentView!
    private(set) var scrollContentView: ScrollContentView!
    
    public init(frame: CGRect,
                segmentStyle: SegmentStyle,
                titles: [String],
                childControllers: [UIViewController],
                parentController: UIViewController) {
        self.segmentStyle = segmentStyle
        self.segmentTitles = titles
        self.childControllers = childControllers
        self.parentController = parentController
        assert(childControllers.count == titles.count, "标题的个数必须和子控制器的个数相同")
    
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

extension ScrollPageView {
    
    private func setup() {
        segmentView = SegmentView(frame: CGRect(x: 0, y: 0, width: self.width, height: segmentStyle.segmentHeight), segmentStyle: segmentStyle, titles: segmentTitles)
        
        scrollContentView = ScrollContentView(frame: CGRect(x: 0, y: segmentView.bottom, width: self.width, height: self.height - segmentView.height), childControllers: childControllers, parentController: parentController)
        
        self.addSubview(segmentView)
        self.addSubview(scrollContentView)
        
        segmentView.titleButtonOnClicked = { [weak self] (text, index) in
            print("segmentView --- \(text) --- \(index)")
            self?.scrollContentView.switchToContent(index: index)
        }
        
        scrollContentView.contentScrollEnded = { [weak self] (index) in
            print("scrollContentView --- \(index)")
            self?.segmentView.switchToTitle(index: index)
        }
    }
    
}
