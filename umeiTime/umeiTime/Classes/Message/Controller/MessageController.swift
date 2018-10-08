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
    private var dataSource: [[String: String]] = [["icon": "", "title": "系统消息"],
                                                  ["icon": "", "title": "点赞消息"],
                                                  ["icon": "", "title": "评论消息"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        setupTableView()
    }

}

extension MessageController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.rowHeight = 50
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
        let dic = dataSource[indexPath.row]
        
        cell.imageView = UIImage(named: dic[""])
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

