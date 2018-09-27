//
//  UIViewFrame.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/27.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

//MARK: - UIView frame
public extension UIView {
    
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    public var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    public var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    public var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
}
