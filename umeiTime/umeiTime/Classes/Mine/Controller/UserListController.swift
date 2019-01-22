//
//  UserListController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/15.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class UserListController: BaseTableViewController {

    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupTableView() {
        tableView.rowHeight = 70
        tableView.register(UINib(resource: R.nib.userListCell), forCellReuseIdentifier: R.nib.userListCell.name)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserListCell = tableView.dequeueReusableCell(withIdentifier: R.nib.userListCell.name, for: indexPath) as! UserListCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    

}
