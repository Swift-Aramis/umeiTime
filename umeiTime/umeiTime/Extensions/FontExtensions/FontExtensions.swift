//
//  FontExtensions.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public typealias Font = UIFont

public extension Font {
    
    /// Font as fit font
    ///  -iPhone5及以下屏幕字号小一号
    public var fit: UIFont {
        if UIScreen.main.bounds.height <= 568 {
            return UIFont(descriptor: fontDescriptor.withSize(self.pointSize - 1), size: 0)
        }
        return self
    }
    
    /// Font as bold font
    public var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }
    
    /// Font as italic font
    public var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
    
    /// Font as monospaced font
    ///     -等宽数字字体
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    public var monospaced: UIFont {
        let settings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        
        let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
        let newDescriptor = fontDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
    
}

