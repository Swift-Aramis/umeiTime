//
//  MListController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/11.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MListController: BaseTableViewController {
    
    weak var delegate: PageViewDelegate?

    convenience init(pageDelegate: PageViewDelegate) {
        self.init(style: .grouped)
        self.delegate = pageDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func layoutTableView() {
        tableView.frame = view.bounds
    }
    
    override func setupTableView() {
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 180
        tableView.register(UINib(resource: R.nib.murmurCell), forCellReuseIdentifier: R.nib.murmurCell.name)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MurmurCell = tableView.dequeueReusableCell(withIdentifier: R.nib.murmurCell.name, for: indexPath) as! MurmurCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.navigationController?.pushViewController(MGroupInfoController(style: .grouped), animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 
        return 10
    }
    
    //MARK: - 实现滚动代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.pageViewDidScroll(scrollView: scrollView)
    }
}
