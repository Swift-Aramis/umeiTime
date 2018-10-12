//
//  UIImageExtensions.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

// MARK: - Initializers
public extension UIImage {
    
    /// SwifterSwift: Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
    
    public enum GradientDirection {
        case vertical, horizontal
    }
    
    public convenience init(startColor: UIColor,
                            endColor: UIColor,
                            size: CGSize,
                            direction: GradientDirection = .vertical) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext() else {
            self.init()
            return
        }
        
        let colorsSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = [startColor.cgColor, endColor.cgColor]
        guard let gradient = CGGradient(colorsSpace: colorsSpace, colors: cgColors as CFArray, locations: nil) else {
            self.init()
            return
        }
        
        if direction == .vertical {
            ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        } else {
            ctx.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        }
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
    
}
