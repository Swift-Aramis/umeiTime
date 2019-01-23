//
//  MGroupController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/11.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MGroupController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func layoutTableView() {
        tableView.frame = view.bounds
    }
    
    override func setupTableView() {
        tableView.rowHeight = 80
        tableView.register(UINib(resource: R.nib.mGroupCell), forCellReuseIdentifier: R.nib.mGroupCell.name)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MGroupCell = tableView.dequeueReusableCell(withIdentifier: R.nib.mGroupCell.name, for: indexPath) as! MGroupCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.navigationController?.pushViewController(MGroupInfoController(style: .grouped), animated: true)
    }
    
}
