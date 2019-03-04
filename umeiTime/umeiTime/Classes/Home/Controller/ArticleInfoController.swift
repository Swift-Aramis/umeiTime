//
//  ArticleInfoController.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/31.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

class ArticleInfoController: BaseTableViewController {
    
    var articleType: UMArticleType = .article
    var dataSource = [ArticleCommentModel]()
    var articleModel: ArticleListModel!
    var page = 1
    private lazy var placeholderV: CommentPlaceholderV = CommentPlaceholderV.loadViewFromNib() as! CommentPlaceholderV
    private let commentV: CommentV = CommentV.loadViewFromNib() as! CommentV

    convenience init(articleType: UMArticleType, articleModel: ArticleListModel) {
        self.init(style: .grouped)
        self.articleType = articleType
        self.articleModel = articleModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = articleModel.title
        tableView.tableHeaderView = ArticleInfoHeader(url: articleModel.html)
        
        setupUI()
        commentListData()
        getInfoData()
    }
    
    private func setupUI() {
        self.view.addSubview(commentV)
        commentV.collectAction = { collected in
            
        }
        commentV.shareAction = {
            
        }
    }
    
    override func layoutTableView() {
        commentV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-SafeAreaBottomInset)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(commentV.snp.top)
        }
    }
    
    override func setupTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "ArticleCommentCell", bundle: nil), forCellReuseIdentifier: "ArticleCommentCell")
        
        tableView.es.addInfiniteScrolling { [weak self] in
            self?.loadMoreCommentListData()
        }
    }
    
    func getInfoData() {
        ArticleApi.modelResultRequest(.articleContent(uid: 1, aid: articleModel.aid, which: articleType), ArticleListModel.self, successHandler: { (data) in
            let model: ArticleListModel = data!
//            print(model.content)
            
        }, errorHandler: { _ in})
    }
    
    func commentListData() {
        
        ArticleApi.arrayResultRequest(.commentList(aid: articleModel.aid, which: articleType, page: page), [ArticleCommentModel].self, successHandler: { [weak self] (data) in
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
        }, errorHandler: { _ in })
    }
    
    private func loadMoreCommentListData() {
        page += 1
        commentListData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 13, y: 20, width: view.width - 40, height: 15))
        label.font = AppFont.secendTextFont
        label.textColor = AppColor.normalGray
        label.text = String(format: "评论 (%d)", 0)
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if dataSource.count == 0 {
            return placeholderV.height
        }
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if dataSource.count == 0 {
            return placeholderV
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleCommentCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCommentCell") as! ArticleCommentCell
        return cell
    }

}
