//
//  MGroupInfoController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/16.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MGroupInfoController: BaseTableViewController {

    private lazy var groupInfoHeaderView: MGroupInfoHeaderView = {
        let groupInfoHeaderV = MGroupInfoHeaderView.loadViewFromNib() as! MGroupInfoHeaderView
        return groupInfoHeaderV
    }()
    
    private var remainOffSetY: CGFloat? //滚动后tableView的预留的偏移量
    private var groupInfoHeaderOriginHeight: CGFloat?//headerView初始高度
    private let whitePublishImg = UIImage(named: "nav_icon_issue_white")?.withRenderingMode(.alwaysOriginal)
    private let greenPublishImg = UIImage(named: "nav_icon_issue_green")?.withRenderingMode(.alwaysOriginal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavItem()
    }
    
    private func setupNavItem() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: whitePublishImg, style: .plain, handler: { [weak self] in
            
            let murmurEditVC = MEditController(style: .grouped)
            self?.navigationController?.pushViewController(murmurEditVC, animated: true)
        })
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

    override func setupTableView() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        setupHeaderView()

        tableView.separatorStyle = .none
        tableView.tableHeaderView = MGroupSignView(text: "记录生活的点滴，留住最美好的回忆。")
        tableView.rowHeight = 80
        tableView.register(R.nib.murmurCell(), forCellReuseIdentifier: R.nib.murmurCell.name)
    }
    
    private func setupHeaderView() {
        remainOffSetY = 0 - NavBarHeight
        groupInfoHeaderOriginHeight = groupInfoHeaderView.height
        
        groupInfoHeaderView.y = -groupInfoHeaderView.height
        tableView.contentInset = UIEdgeInsets(top: groupInfoHeaderView.height, left: 0, bottom: 0, right: 0 )
        tableView.addSubview(groupInfoHeaderView)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MurmurCell = tableView.dequeueReusableCell(withIdentifier: R.nib.murmurCell.name, for: indexPath) as! MurmurCell
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

extension MGroupInfoController {
    
    private func changeNavBarSytle() {
        if tableView.contentOffset.y >= remainOffSetY! {
            self.navigationController?.navigationBar.tintColor = AppColor.darkBlack
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil // 恢复shadowImage
            self.navigationItem.rightBarButtonItem?.image = greenPublishImg
        } else {
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage() // 去掉shadowImage
            self.navigationItem.rightBarButtonItem?.image = whitePublishImg
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //改变navBar
        changeNavBarSytle()
        
        //图片下拉放大
        let yOffset = scrollView.contentOffset.y
        if yOffset < -groupInfoHeaderOriginHeight! {
            groupInfoHeaderView.y = yOffset
            groupInfoHeaderView.height = -yOffset
            print("yOffset")
            print(groupInfoHeaderView.height)
        } else {
            groupInfoHeaderView.y = -groupInfoHeaderOriginHeight!
            groupInfoHeaderView.height = groupInfoHeaderOriginHeight!
            print("else yOffset")
            print(groupInfoHeaderView.height)
        }
    }
}

class MGroupSignView: UIView {
    
    lazy var signLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = AppColor.darkBlack
        label.textAlignment = .left
        label.font = AppFont.normalTextFont
        label.text = "记录生活的点滴，留住最美好的回忆。"
        return label
    }()
    
    init(text: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        self.backgroundColor = UIColor.white
        self.addSubview(signLabel)
        signLabel.frame = CGRect(x: 13, y: 0, width: self.width - 13*2, height: self.height)
        signLabel.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
