//
//  SearchResultController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/6.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class SearchResultController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
    }
}
