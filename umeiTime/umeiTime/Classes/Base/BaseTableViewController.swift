//
//  BaseTableViewController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/7.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - SubclassingHooks
    /// 布局 tableView
    public func layoutTableView() {
        tableView.frame = view.bounds
    }
    /// 设置 tableView
    public func setupTableView() {}
    
    //MARK: - Private
    public private(set) var tableView: UITableView!
    public private(set) var style: UITableView.Style = .plain
    
    convenience init(style: UITableView.Style = .plain) {
        self.init()
        self.style = style
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutTableView()
    }
    
    private func initTableView() {
        tableView = UITableView(frame: CGRect.zero, style: style)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.groupTableViewBackground
        if tableView.style == .plain {
            tableView.tableFooterView = UIView()
        }
        view.addSubview(tableView)
        
        setupTableView()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionV = UIView()
        sectionV.backgroundColor = UIColor.groupTableViewBackground
        return sectionV
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerV = UIView()
        footerV.backgroundColor = UIColor.groupTableViewBackground
        return footerV
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - DEBUG
    override var description: String {
#if DEBUG
        if !self.isViewLoaded {
            return super.description
        }
        
        var result = super.description + "\ntableView:\t\t\t\t" + self.tableView.description
        let sections = self.tableView.dataSource?.numberOfSections!(in: self.tableView) ?? 0
        if sections > 0 {
            var sectionCountString = String(format: "\ndataCount(%d):\t\t\t\t(\n", Int(sections))
            for i in 0..<sections {
                let rows = self.tableView.dataSource?.tableView(self.tableView, numberOfRowsInSection: i) ?? 0
                sectionCountString += String(format: "\t\t\t\t\t\t\tsection%d - rows%d%@\n", i, rows, i < sections - 1 ? "," : "")
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
