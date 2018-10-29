//
//  PhotoBrowserConfig.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/22.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public enum PhotoBrowserLoadingMode {
    case loopDiagram    //环状
    case pieDiagram     //饼状
}

public struct PhotoBrowserConfig {
    
    static public let shared: PhotoBrowserConfig = {
        return PhotoBrowserConfig()
    }()
    
    // save文字提示
    public var saveSuccessText = "保存成功"
    public var saveFailText = "保存失败"

    // browser背景色
    public var browserBgColor = UIColor.black.withAlphaComponent(0.95)
    
    // 加载器
    public var loadingBgColor = UIColor.black.withAlphaComponent(0.7)
    public var loadingMode: PhotoBrowserLoadingMode = .loopDiagram
    public var loadingItemMargin: CGFloat = 10

}

