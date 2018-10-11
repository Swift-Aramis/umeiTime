//
//  HomeListController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

enum HomeListType {
    case article
    case pic
}

class HomeListController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    var listType: HomeListType = .article
    
    convenience init(type: HomeListType) {
        self.init()
        self.listType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = UIColor.green
    }
    
}

extension HomeListController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        
        switch listType {
        case .article:
            tableView.rowHeight = 255
            tableView.register(R.nib.homeArticleCell(), forCellReuseIdentifier: R.nib.homeArticleCell.name)
            
        case .pic:
            tableView.rowHeight = 150
            tableView.register(R.nib.homePicCell(), forCellReuseIdentifier: R.nib.homePicCell.name)
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch listType {
        case .article:
            let cell: HomeArticleCell = tableView.dequeueReusableCell(withIdentifier: R.nib.homeArticleCell.name, for: indexPath) as! HomeArticleCell
            
            return cell
            
        case .pic:
            let cell: HomePicCell = tableView.dequeueReusableCell(withIdentifier: R.nib.homePicCell.name, for: indexPath) as! HomePicCell
            
            return cell
        }
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if listType == .pic && section == 0 {
          return 10
        }
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

