//
//  UIViewLoads.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/27.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ self.addSubview($0) })
    }
    
    public func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }

    /// Load view from nib.
    ///
    /// - Parameters:
    ///   - name: nib name.
    ///   - bundle: bundle of nib (default is nil).
    /// - Returns: optional UIView (if applicable).
    public class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
    /// Load view from nib.
    public class func loadViewFromNib() -> UIView? {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as? UIView
    }
    
}
