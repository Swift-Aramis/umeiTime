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
    var dataSource = [ArticleListModel]()
    
    convenience init(type: HomeListType) {
        self.init()
        self.listType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefresh()
        loadListData()
    }
    
    private func setupRefresh() {
        //添加下拉刷新和上拉加载
        tableView.addPullToRefreshWithAction({ [weak self] in
            self?.reloadListData()
//            OperationQueue().addOperation {
//                sleep(4)
//                OperationQueue.main.addOperation {
//                    self.tableView.stopPullToRefresh()
//                }
//            }
        }, withAnimator: refreshAnimator)
        
        tableView.es.addInfiniteScrolling { [weak self] in
            self?.loadMoreListData()
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
            self?.endLoadingAnimation(self?.tableView)
            guard let data = data else {
                self?.tableView.es.noticeNoMoreData()
                return
            }
            
            DispatchQueue.global().async {
                if self?.page == 1 {
                    self?.dataSource = data
                } else {
                    self?.dataSource.append(contentsOf: data)
                }
                
                DispatchQueue.main.async {
                     self?.tableView.reloadData()
                }
            }
            
        }, errorHandler: { [weak self] _ in
            self?.endLoadingAnimation(self?.tableView)
        })
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //1.图片变形问题
    /**
     图片尺寸问题
     图片太大
     */
    //2.滚动卡顿问题
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch listType {
        case .article:
            let cell: HomeArticleCell = tableView.dequeueReusableCell(withIdentifier: R.nib.homeArticleCell.name, for: indexPath) as! HomeArticleCell
            cell.articleModel = dataSource[indexPath.section]
            return cell
            
        case .pic:
            let cell: HomePicCell = tableView.dequeueReusableCell(withIdentifier: R.nib.homePicCell.name, for: indexPath) as! HomePicCell
            cell.picModel = dataSource[indexPath.section]
            return cell
        }
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if listType == .pic && section == 0 {
          return 15
        }
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if listType == .pic {
            return 15
        }
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

