//
//  MineController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MineController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    private let mineHeaderView: MineHeaderView = MineHeaderView.loadViewFromNib() as! MineHeaderView
    
    private lazy var dataSource: [[NormalCellModel]] = {
        var section = [[NormalCellModel]]()
        let sectionOne = [NormalCellModel(icon: "mine_icon_collect", title: "我的收藏"),
                          NormalCellModel(icon: "mine_icon_atlas", title: "我的图集"),
                          NormalCellModel(icon: "mine_icon_praise", title: "我赞过的")]
        section.append(sectionOne)
        let sectionTwo = [NormalCellModel(icon: "", title: "开屏图集"),
                          NormalCellModel(icon: "", title: "图文卡片")]
        section.append(sectionTwo)
        let sectionThree = [NormalCellModel(icon: "mine_icon_setting", title: "设置"),
                            NormalCellModel(icon: "", title: "关于优美")]
        section.append(sectionThree)
        return section
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        setupTableView()
    }

}

extension MineController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MineCell")
        tableView.tableHeaderView = mineHeaderView
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = AppColor.darkBlack
        cell.textLabel?.font = AppFont.firstTextFont
        cell.textLabel?.text = dataSource[indexPath.section][indexPath.row].title
        cell.imageView?.image = UIImage(named: dataSource[indexPath.section][indexPath.row].icon)
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = UIView()
        section.backgroundColor = UIColor.groupTableViewBackground
        return section
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}


