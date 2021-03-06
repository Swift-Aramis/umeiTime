//
//  HomeListController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

enum HomeListType: Int {
    case article, pic
}

class HomeListController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    var listType: HomeListType = .article //页面用
    var articleType: UMArticleType = .article //接口用
    var classType: String?
    var page = 1
    var dataSource = [ArticleListModel]()
    
    convenience init(listType: HomeListType, classType: String? = nil) {
        self.init()
        self.listType = listType
        self.classType = classType
        
        if listType == .pic {
            articleType = .picture
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefresh()
        loadListData()
    }
    
    private func setupRefresh() {
        tableView.addPullToRefreshWithAction({ [weak self] in
            self?.reloadListData()
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
        var target: ArticleApi = .allList(which: articleType, page: page)
        if let classType = classType {
            target = .articleList(uid: 1, type: classType, which: articleType, page: page)
        }
        
        ArticleApi.arrayResultRequest(target, [ArticleListModel].self, successHandler: { [weak self] (data) in
            self?.endLoadingAnimation(self?.tableView)
            guard let data = data, data.count != 0 else {
                self?.tableView.es.noticeNoMoreData()
                return
            }
            
            if self?.page == 1 {
                self?.dataSource = data
            } else {
                self?.dataSource.append(contentsOf: data)
            }
            
            self?.tableView.reloadData()
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
        let infoVC = ArticleInfoController(articleType: articleType, articleModel: dataSource[indexPath.section])
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
}

