//
//  UIViewShadow.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/27.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public extension UIView {
    
    public var shadowcColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is black).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (Defaults to (0, -3)).
    ///   - opacity: shadow opacity (default is 0.2) , [0,1] range
    public func addShadow(ofColor color: UIColor = UIColor.black, radius: CGFloat = 3, offset: CGSize = CGSize(width: 0, height: -2), opacity: Float = 0.2) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
}
