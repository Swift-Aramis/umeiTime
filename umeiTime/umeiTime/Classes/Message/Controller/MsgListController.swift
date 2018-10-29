//
//  MsgListController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MsgListController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupTableView() {
        tableView.rowHeight = 110
        tableView.register(R.nib.msgListCell(), forCellReuseIdentifier: R.nib.msgListCell.name)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MsgListCell = tableView.dequeueReusableCell(withIdentifier: R.nib.msgListCell.name, for: indexPath) as! MsgListCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.navigationController?.pushViewController(MurInfoController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

}
