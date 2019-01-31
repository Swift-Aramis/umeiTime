//
//  ArticleInfoHeader.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/31.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit
import WebKit

class ArticleInfoHeader: WKWebView {

    convenience init(url: String) {
        self.init()
        guard let requestUrl = URL(string: url) else { return }
        setupWK()
        self.load(URLRequest(url: requestUrl))
    }
}

extension ArticleInfoHeader: WKNavigationDelegate {
    
    func setupWK() {
        self.width = ScreenWidth
//        self.height = 300
        self.navigationDelegate = self
        self.isUserInteractionEnabled = false;
        self.scrollView.bounces = false;
        self.scrollView.isScrollEnabled = false;
        self.scrollView.showsVerticalScrollIndicator = false;
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.body.offsetHeight;") { (any, error) in
//            Optional<Any>
//                - some : 13296
            
            guard let height: Int = any as? Int else {
                return
            }
            print("height === \(height)")
            
//            guard let h = Double(height) else {
//                return
//            }
            self.height = CGFloat(height)
            //加载完要调整坐标
            let pVC: ArticleInfoController = self.parentViewController as! ArticleInfoController
            pVC.tableView.reloadData()
        }
    }
}
