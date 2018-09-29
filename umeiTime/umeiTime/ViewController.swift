//
//  ViewController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/5.
//  Copyright © 2018年 提运佳. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmpView = UIView()
        view.addSubview(tmpView)
        tmpView.size = CGSize(width: 100, height: 100)
        tmpView.centerX = view.centerX
        tmpView.bottom = 144
        tmpView.backgroundColor = AppColor.darkBlack
        tmpView.roundCorners([.topLeft, .topRight], radius: 10)
        tmpView.fadeOut(duration: 2)
        
        view.addSubview(tmpLabel)
        tmpLabel.frame = tmpView.frame
        
        let tmpView2 = UIView()
        view.addSubview(tmpView2)
        tmpView2.size = CGSize(width: 100, height: 100)
        tmpView2.centerX = view.centerX
        tmpView2.top = tmpView.bottom + 30
        tmpView2.backgroundColor = UIColor.green
//        tmpView2.roundCorners([.topLeft, .topRight], radius: 10)
        tmpView2.addShadow(ofColor: .red, radius: 5.0, offset: .zero, opacity: 0.5)
        tmpView2.alpha = 0
        tmpView2.fadeIn(duration: 2)
        
        view.addSubview(tmpLabel2)
        tmpLabel2.frame = tmpView2.frame

        let tmpView3 = UIView()
        view.addSubview(tmpView3)
        tmpView3.size = CGSize(width: 100, height: 100)
        tmpView3.centerX = view.centerX
        tmpView3.top = tmpView2.bottom + 30
        tmpView3.backgroundColor = UIColor.blue
        tmpView3.roundCorners([.topLeft, .topRight], radius: 10)
//        tmpView3.rotate(byAngle: .pi, ofType: .radians, animated: true, duration: 2)
        tmpView3.rotate(byAngle: 2, ofType: .radians, animated: true, duration: 2, completion: nil)

        let tmpView4 = UIView()
        view.addSubview(tmpView4)
        tmpView4.size = CGSize(width: 100, height: 100)
        tmpView4.centerX = view.centerX
        tmpView4.top = tmpView3.bottom + 30
        tmpView4.backgroundColor = UIColor.green
        tmpView4.roundCorners([.topLeft, .topRight], radius: 10)
//        tmpView4.rotate(toAngle: .pi, ofType: .radians, animated: true, duration: 2)
        tmpView4.rotate(toAngle: 2, ofType: .radians, animated: true, duration: 2, completion: nil)

        let tmpView5 = UIView()
        view.addSubview(tmpView5)
        tmpView5.size = CGSize(width: 100, height: 100)
        tmpView5.centerX = view.centerX
        tmpView5.top = tmpView4.bottom + 30
        tmpView5.backgroundColor = UIColor.yellow
        tmpView5.roundCorners([.topLeft, .topRight], radius: 10)
        tmpView5.scale(by: CGPoint(x: 2, y: 1), animated: true, duration: 2, completion: nil)
        
        let tmpView6 = UIView()
        view.addSubview(tmpView6)
        tmpView6.size = CGSize(width: 100, height: 100)
        tmpView6.centerX = view.centerX
        tmpView6.top = tmpView5.bottom + 30
        tmpView6.backgroundColor = UIColor.cyan
        tmpView6.roundCorners([.topLeft, .topRight], radius: 10)
        tmpView6.shake(direction: .horizontal)
    }
    
    private let tmpLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        label.textColor = UIColor.black
        label.textAlignment = .left
        let font = UIFont.preferredFont(forTextStyle: .body)
        let boldFont = font.monospaced
        label.font = font
        label.numberOfLines = 0
        label.text = "111111"
        return label
    }()
    
    private let tmpLabel2: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        label.textColor = UIColor.black
        label.textAlignment = .left
        let font = UIFont.preferredFont(forTextStyle: .body)
        let boldFont = font.fit
        label.font = boldFont
        label.numberOfLines = 0
        label.text = "111111"
        return label
    }()


}

