//
//  SearchResultController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/6.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

enum SearchType {
    case article, pic, mur, user
}

class SearchResultController: BaseTableViewController {

    var page = 1
    var searchType: SearchType = .article
    
    convenience init(searchType: SearchType) {
        self.init()
        self.searchType = searchType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupTableView() {
        
    }
    
    private func loadListData() {
        switch searchType {
        case .article:
            print("")
        case .pic:
            print("")
        case .mur:
            print("")
        case .user:
            print("")
        }
    }
}
