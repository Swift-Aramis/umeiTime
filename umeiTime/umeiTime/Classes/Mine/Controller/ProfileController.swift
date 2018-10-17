//
//  ProfileController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/11.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

protocol PageViewDelegate: class {
    func pageViewDidScroll(scrollView: UIScrollView)
}

class MultiplePanGestureTableView: UITableView, UIGestureRecognizerDelegate {
    /// 返回 true - 能同时识别多个滚动手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (gestureRecognizer is UIPanGestureRecognizer) && (otherGestureRecognizer is UIPanGestureRecognizer)
    }
}

class ProfileController: UIViewController {
    
    private lazy var profileView: ProfileView = {
        let profileV = ProfileView.loadViewFromNib() as! ProfileView
        return profileV
    }()
    private var titles = ["微语(0)", "小组(0)"]
    private var segmentView: SegmentView!
    private var scrollContentView: ScrollContentView!
    private var tableView: MultiplePanGestureTableView!
    private var pageScrollView: UIScrollView?
    private var remainOffSetY: CGFloat? //滚动后tableView的预留的偏移量
    private var profileViewOriginHeight: CGFloat?//headerView初始高度

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItem()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeNavBarSytle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.tintColor = AppColor.darkBlack
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil // 恢复shadowImage
    }
    
    private func setupNavItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_back"), style: .plain, handler: { [weak self] in
            
            self?.navigationController?.popViewController(animated: true)
        })
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_edit"), style: .plain, handler: { [weak self] in
            
            self?.navigationController?.pushViewController(EditProfileController(), animated: true)
        })
    }
    
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        setupContentView()
        
        tableView = MultiplePanGestureTableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        remainOffSetY = 0 - NavBarHeight - segmentView.height
        profileViewOriginHeight = profileView.height
        
        profileView.sectionView.addSubview(segmentView)
        profileView.y = -profileView.height
        //初始tableView偏移量为 -profileView.height
        tableView.contentInset = UIEdgeInsets(top: profileView.height, left: 0, bottom: 0, right: 0)
        tableView.addSubview(profileView)
        tableView.rowHeight = scrollContentView.height
    }
    
    private func setupContentView() {
        var segmentStyle = SegmentStyle()
        segmentStyle.showsSeparatorLine = true
        segmentView = SegmentView(frame: CGRect(x: 0, y: 0, width: view.width, height: 44), segmentStyle: segmentStyle, titles: titles)
        segmentView.backgroundColor = UIColor.white
        
        let contentHeight = view.height - segmentView.height - NavBarHeight
        let controllers = [MGroupController(pageDelegate: self),
                           MGroupCollectionController(pageDelegate: self)]
        scrollContentView = ScrollContentView(frame: CGRect(x: 0, y: 0, width: view.width, height: contentHeight), childControllers: controllers, parentController: self)
        
        segmentView.titleButtonOnClicked = { [weak self] (text, index) in
            self?.scrollContentView.switchToContent(index: index)
        }
        scrollContentView.contentScrollEnded = { [weak self] (index) in
            self?.segmentView.switchToTitle(index: index)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.addSubview(scrollContentView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}

extension ProfileController: PageViewDelegate {
    
    private func changeNavBarSytle() {
        if tableView.contentOffset.y >= remainOffSetY! {
            self.navigationController?.navigationBar.tintColor = AppColor.darkBlack
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil // 恢复shadowImage
        } else {
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage() // 去掉shadowImage
        }
    }
    
    func pageViewDidScroll(scrollView: UIScrollView) {
        pageScrollView = scrollView

        if tableView.contentOffset.y < remainOffSetY! {
            scrollView.contentOffset = CGPoint.zero
            scrollView.showsVerticalScrollIndicator = false
        } else {
            tableView.contentOffset.y = remainOffSetY!
            scrollView.showsVerticalScrollIndicator = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //改变navBar
        changeNavBarSytle()
        
        //图片下拉放大
        let yOffset = scrollView.contentOffset.y
        if yOffset < -profileViewOriginHeight! {
            profileView.y = yOffset
            profileView.height = -yOffset
        } else {
            profileView.y = -profileViewOriginHeight!
            profileView.height = profileViewOriginHeight!
        }
        
        //设置悬停位置
        guard let pageScrollV = pageScrollView else { return }
        if pageScrollV.contentOffset.y > CGFloat(0) {
            tableView.contentOffset.y = remainOffSetY!
        }
    }
}
