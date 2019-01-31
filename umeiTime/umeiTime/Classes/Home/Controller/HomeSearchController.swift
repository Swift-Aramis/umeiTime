//
//  HomeSearchController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/6.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomeSearchController: BaseController {
    
    private let searchTF: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        
        let searchIcon = UIImageView.init(image: R.image.nav_icon_search())
        searchIcon.contentMode = .center
        textField.leftView = searchIcon
        textField.leftView?.frame.size = CGSize(width: searchIcon.width + 20, height: searchIcon.height)
        textField.leftViewMode = .always

        textField.borderColor = Color(hexString: "#D7D7D7")
        textField.borderWidth = 1
        textField.cornerRadius = textField.height/2
        textField.font = AppFont.secendTextFont
        textField.attributedPlaceholder = NSAttributedString(string: "搜索文章、图片、微语、用户", attributes: [.foregroundColor: AppColor.normalGray])
        return textField
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchView()
        setupContentView()
        
        searchTF.becomeFirstResponder()
    }
    
    private func setupSearchView() {
        let searchView = UIView()
        searchView.x = 0
        searchView.y = 0
        searchView.size = CGSize(width: ScreenWidth, height: NavBarHeight)
        view.addSubview(searchView)
        
        let cancleBtn = UIButton()
        cancleBtn.titleLabel?.font = AppFont.secendTextFont
        cancleBtn.setTitleColor(AppColor.darkBlack, for: .normal)
        cancleBtn.setTitle("取消", for: .normal)
        searchView.addSubview(cancleBtn)
        cancleBtn.sizeToFit()
        cancleBtn.height = 34
        cancleBtn.x = searchView.width - cancleBtn.width - 12
        cancleBtn.y = searchView.height - cancleBtn.height - 5
        cancleBtn.onTap { [weak self] in
            self?.dismiss(animated: false, completion: nil)
        }

        searchView.addSubview(searchTF)
        searchTF.x = 12
        searchTF.y = cancleBtn.y
        searchTF.width = cancleBtn.x - 10 - searchTF.x
        searchTF.height = cancleBtn.height
        searchTF.cornerRadius = searchTF.height/2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setupContentView() {
        var segmentStyle = SegmentStyle()
        segmentStyle.segmentHeight = 34
        segmentStyle.indicatorLineHeight = 2
        segmentStyle.normalTextFont = AppFont.secendTextFont
        segmentStyle.selectedTextFont = AppFont.secendTextFont.bold
        
        let titles = ["文章", "图片", "微语", "用户"]
        let controllers = [SearchResultController(searchType: .article),
                           SearchResultController(searchType: .pic),
                           SearchResultController(searchType: .mur),
                           SearchResultController(searchType: .user)]
        
        let scrollPageV = ScrollPageView(frame: CGRect(x: 0, y: NavBarHeight, width: view.width, height: view.height - NavBarHeight), segmentStyle: segmentStyle, titles: titles, childControllers: controllers, parentController: self)
        view.addSubview(scrollPageV)
    }
    
}
