//
//  MurInfoController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MurInfoController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
    }

    override func setupTableView() {
        tableView.estimatedRowHeight = 180
        tableView.register(UINib(resource: R.nib.murmurCell), forCellReuseIdentifier: R.nib.murmurCell.name)
        tableView.register(UINib(resource: R.nib.mCommentCell), forCellReuseIdentifier: R.nib.mCommentCell.name)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: MurmurCell = tableView.dequeueReusableCell(withIdentifier: R.nib.murmurCell.name, for: indexPath) as! MurmurCell
            return cell
        } else {
            let cell: MCommentCell = tableView.dequeueReusableCell(withIdentifier: R.nib.mCommentCell.name, for: indexPath) as! MCommentCell
            return cell
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
