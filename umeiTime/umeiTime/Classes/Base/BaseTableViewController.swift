//
//  BaseTableViewController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/7.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseController {

    lazy var tableView: UITableView = {
        let tableV = UITableView(frame: self.view.bounds, style: .plain)
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

}
