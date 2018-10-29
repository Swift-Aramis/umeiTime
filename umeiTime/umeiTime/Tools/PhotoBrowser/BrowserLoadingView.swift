//
//  BrowserLoadingView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/22.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

public class BrowserLoadingView: UIView {

    public var progress: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
            if progress >= 1 {
                self.removeFromSuperview()
            }
        }
    }
    public var mode: PhotoBrowserLoadingMode = .loopDiagram
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = PhotoBrowserConfig.shared.loadingBgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        UIColor.white.set()
        
        let xCenter = rect.size.width * 0.5
        let yCenter = rect.size.height * 0.5
        let margin = PhotoBrowserConfig.shared.loadingItemMargin
        let bgColor = PhotoBrowserConfig.shared.loadingBgColor
        let radius = min(rect.size.width * 0.5, rect.size.height * 0.5) - margin
        switch mode {
        case .pieDiagram:
            print("饼状进度条")
            let w = radius * 2 + margin
            let h = w
            let x = (rect.size.width - w) * 0.5
            let y = (rect.size.height - h) * 0.5
            ctx.addEllipse(in: CGRect(x: x, y: y, width: w, height: h))
            ctx.fillPath()
            
            bgColor.set()
            ctx.move(to: CGPoint(x: xCenter, y: yCenter))
            ctx.addLine(to: CGPoint(x: xCenter, y: 0))
            let to: CGFloat = -.pi/2 + self.progress * .pi*2 + 0.001; // 初始值
            ctx.addArc(center: CGPoint(x: xCenter, y: yCenter), radius: radius, startAngle: -.pi/2, endAngle: to, clockwise: true)
            ctx.closePath()
            ctx.fillPath()
        default:
            print("环状进度条")
            ctx.setLineWidth(15);
            ctx.setLineCap(.round)
            let to: CGFloat = -.pi/2 + self.progress * .pi*2 + 0.05; // 初始值0.05
            ctx.addArc(center: CGPoint(x: xCenter, y: yCenter), radius: radius, startAngle: -.pi/2, endAngle: to, clockwise: false)
            ctx.strokePath()
        }
    }
}
