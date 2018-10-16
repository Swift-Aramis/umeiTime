//
//  SegmentView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public typealias TitleButtonOnClicked = (_ text: String, _ index: Int) -> Void

public class SegmentView: UIView {

    public var segmentStyle: SegmentStyle!
    public var segmentTitles: [String]!

    public var titleButtonOnClicked: TitleButtonOnClicked?
    private var titleButtons: [UIButton] = []
    private lazy var indicatorLine = UIView()
    private lazy var separatorLine = UIView()
    private lazy var selectedButton = UIButton()
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.showsHorizontalScrollIndicator = false
        return scrollV
    }()
    
    public init(frame: CGRect, segmentStyle: SegmentStyle, titles: [String]) {
        self.segmentStyle = segmentStyle
        self.segmentTitles = titles
        
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SegmentView {
    
    private func setup() {
        addSubview(scrollView)
        scrollView.frame = self.bounds
        
        setupTitleButtons()
        
        setupIndicatorLine()
        
        setupSepLine()
    }
    
    private func switchSelected(_ button: UIButton) {
        selectedButton.isSelected = false
        button.isSelected = true
        selectedButton = button
        
        UIView.animate(withDuration: 0.3) {
            self.indicatorLine.centerX = self.selectedButton.centerX
        }
    }
    
    @objc private func itemClicked(_ button: UIButton) {
        
        switchSelected(button)
        
        titleButtonOnClicked?((button.titleLabel?.text)!, button.tag)
    }
    
    private func setupTitleButtons() {
        
        var lastRight: CGFloat = 0
        for (index, title) in segmentTitles.enumerated() {
            let button = UIButton()
            button.tag = index
            button.setTitle(title, for: .normal)
            button.setTitleColor(segmentStyle.normalTextColor, for: .normal)
            button.setTitleColor(segmentStyle.selectedTextColor, for: .selected)
            button.titleLabel?.font = segmentStyle.normalTextFont
            button.addTarget(self, action: #selector(itemClicked(_:)), for: .touchUpInside)
            scrollView.addSubview(button)
            titleButtons.append(button)
            
            if (segmentStyle.isScrollEnabled) {//适应大小
                scrollView.isScrollEnabled = true
                let size = button.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: scrollView.height))
                button.size = CGSize(width: size.width + 10, height: scrollView.height)
                button.y = 0
                button.x = lastRight + segmentStyle.itemGap
                lastRight = button.right
                
            } else {//均分
                scrollView.isScrollEnabled = false
                button.size = CGSize(width: scrollView.width / CGFloat(segmentTitles.count), height: scrollView.height)
                button.x = CGFloat(index) * button.width
                button.y = 0
            }
            
            if index == 0 {
                button.isSelected = true
                selectedButton = button
                //滚动到相应的contentView
            }
            
        }
        
        if (segmentStyle.isScrollEnabled) {
            scrollView.contentSize = CGSize(width: lastRight + segmentStyle.itemGap, height: scrollView.height)
        }
    }
    
    private func setupIndicatorLine() {
        if !segmentStyle.showsIndicatorLine {
            return
        }
        
        scrollView.addSubview(indicatorLine)
        indicatorLine.backgroundColor = segmentStyle.indicatorLineColor
        let iHeight = segmentStyle.indicatorLineHeight
        let iWidth = segmentStyle.indicatorLineWidth
        indicatorLine.size = CGSize(width: iWidth, height: iHeight)
        indicatorLine.bottom = scrollView.height - separatorLine.height
        indicatorLine.centerX = selectedButton.centerX
        
        if segmentStyle.indicatorLineCornered {
            indicatorLine.cornerRadius = indicatorLine.height/2
        }
    }
    
    private func setupSepLine() {
        if !segmentStyle.showsSeparatorLine {
            return
        }
        
        self.addSubview(separatorLine)
        separatorLine.backgroundColor = segmentStyle.separatorLineColor
        let sHeight = segmentStyle.separatorLineHeight
        separatorLine.frame = CGRect(x: 0, y: scrollView.height - sHeight, width: scrollView.width, height: sHeight)
    }
    
}

//MARK: - Public Helper
extension SegmentView {
    // 切换到第几个标题
    public func switchToTitle(index: Int) {
        if titleButtons.count == 0 {
            return
        }
        
        let button = titleButtons[index]
        if button === selectedButton {
            return
        }
        
        switchSelected(button)
    }
}
