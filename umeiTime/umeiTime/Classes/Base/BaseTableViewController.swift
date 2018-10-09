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
    
    override var description: String {
#if DEBUG
        if !self.isViewLoaded {
            return super.description
        }
        
        var result = super.description + "\ntableView:\t\t\t\t" + self.tableView.description
        let sections = self.tableView.dataSource?.numberOfSections!(in: self.tableView) ?? 0
        if sections > 0 {
            var sectionCountString = String(format: "\ndataCount(%@):\t\t\t\t(\n", Int(sections))
            for i in 0..<sections {
                let rows = self.tableView.dataSource?.tableView(self.tableView, numberOfRowsInSection: i) ?? 0
                sectionCountString += String(format: "\t\t\t\t\t\t\tsection%@ - rows%@%@\n", i, rows, i < sections - 1 ? "," : "")
            }
            sectionCountString += "\t\t\t\t\t\t)"
            result += sectionCountString
        }
        return result
#else
        return super.description
#endif
    }
    

}
