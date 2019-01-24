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
    var page = 1
    var dataSource: [ArticleListModel]?
    
    convenience init(type: HomeListType) {
        self.init()
        self.listType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefresh()
    }
    
    private func setupRefresh() {
        //添加下拉刷新和上拉加载
        tableView.addPullToRefreshWithAction({
            OperationQueue().addOperation {
                sleep(4)
                OperationQueue.main.addOperation {
                    self.tableView.stopPullToRefresh()
                }
            }
        }, withAnimator: refreshAnimator)
        
        tableView.es.addInfiniteScrolling {
            
        }
    }
    
    private func reloadListData() {
        page = 1
        loadListData()
    }
    
    private func loadMoreListData() {
        page += 1
        loadListData()
    }
    
    private func loadListData() {
        var articleType: UMArticleType = .article
        if listType == .pic {
            articleType = .picture
        }
        ArticleApi.arrayResultRequest(.allList(which: articleType, page: page), [ArticleListModel].self, successHandler: { [weak self] (data) in
            //停止刷新
            //停止加载
            self?.tableView.stopPullToRefresh()
            self?.tableView.es.stopLoadingMore()
            guard let data = data else {
                // 1 - kong - 代理

                // 2 - 没有更多数据
                self?.tableView.es.noticeNoMoreData()
                return
            }
            
            if self?.page == 1 {
                self?.dataSource = data
            } else {
//                self?.dataSource?.append(contentsOf: data ?? [])
            }
        }, errorHandler: {_ in })
    }
    
    
}

extension HomeListController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        
        switch listType {
        case .article:
            tableView.rowHeight = 255
            tableView.register(UINib(resource: R.nib.homeArticleCell), forCellReuseIdentifier: R.nib.homeArticleCell.name)
            
        case .pic:
            tableView.rowHeight = 150
            tableView.register(UINib(resource: R.nib.homePicCell), forCellReuseIdentifier: R.nib.homePicCell.name)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

