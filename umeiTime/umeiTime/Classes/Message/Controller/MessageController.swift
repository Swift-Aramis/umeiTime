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
    
    private var dataSource: [NormalCellModel] = [NormalCellModel(icon: "", title: "系统消息"),
                                                 NormalCellModel(icon: "", title: "点赞消息"),
                                                 NormalCellModel(icon: "", title: "评论消息")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        setupTableView()
    }

}

extension MessageController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
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
    }
    
}

