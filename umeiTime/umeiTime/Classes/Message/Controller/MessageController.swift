//
//  MessageController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MessageController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: [SystemCellModel] = [SystemCellModel(icon: "msg_icon_sys", title: "系统消息"),
                                                 SystemCellModel(icon: "msg_icon_like", title: "点赞消息"),
                                                 SystemCellModel(icon: "msg_icon_comment", title: "评论消息")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        setupNavItem()
        setupTableView()
    }
    
    private func setupNavItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_icon_friend"), style: .plain, handler: { [weak self] in
        })
    }

}

extension MessageController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 0)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = AppColor.darkBlack
        cell.textLabel?.font = AppFont.firstTextFont
        cell.textLabel?.text = dataSource[indexPath.row].title
        cell.imageView?.image = UIImage(named: dataSource[indexPath.row].icon)
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let umeiProfileVC = ProfileController()
                self.navigationController?.pushViewController(umeiProfileVC, animated: true)
                
            } else {
                let msgListVC = MsgListController()
                msgListVC.title = dataSource[indexPath.row].title
                self.navigationController?.pushViewController(msgListVC, animated: true)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1 //去除最后一行cell的分割线
    }
    
}

