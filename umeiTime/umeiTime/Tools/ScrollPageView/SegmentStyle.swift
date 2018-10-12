//
//  SegmentStyle.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public struct SegmentStyle {
    /// 文字
    public var normalTextColor = Color(hexString: "#666666")!
    public var selectedTextColor = Color(hexString: "#333333")!
    public var normalTextFont = UIFont.systemFont(ofSize: 17)
    public var selectedTextFont = UIFont.boldSystemFont(ofSize: 17)

    /// 文字间隔
    public var itemGap: CGFloat = 35.0

    /// 底部分割线
    public var showsSeparatorLine = false
    public var separatorLineHeight: CGFloat = 0.5
    public var separatorLineColor = Color(hexString: "#DDDDDD")!
    
    /// 指示线
    public var showsIndicatorLine = true
    public var indicatorLineHeight: CGFloat = 3.0
    public var indicatorLineWidth: CGFloat = 36.0
    public var indicatorLineCornered = true
    public var indicatorLineColor = Color(hexString: "#333333")!
    
    /// 是否可滚动
    public var isScrollEnabled = false
    
    public var segmentHeight: CGFloat = 44.0
}
