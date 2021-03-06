//
//  HomeClassController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/5.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomeClassController: BaseController {

    @IBOutlet weak var collectionView: UICollectionView!
    var articleType: UMArticleType = .article
    var dataSource = [ArticleClassModel]()
    
    convenience init(type: UMArticleType) {
        self.init()
        self.articleType = type
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        setupCollectionView()
        loadClassData()
    }
    
    private func loadClassData() {
        ArticleApi.arrayResultRequest(.catalogList(uid: 1, which: articleType), [ArticleClassModel].self, successHandler: { [weak self] (data) in
            self?.endLoadingAnimation(self?.collectionView)
            guard let data = data else {
                return
            }
            self?.dataSource = data
            self?.collectionView.reloadData()
        }, errorHandler: { _ in })
    }
}

extension HomeClassController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        collectionView.register(UINib(resource: R.nib.homeClassCell), forCellWithReuseIdentifier: R.nib.homeClassCell.name)
        
        collectionView.addPullToRefreshWithAction({ [weak self] in
            self?.loadClassData()
        }, withAnimator: refreshAnimator)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeClassCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.homeClassCell.name, for: indexPath) as! HomeClassCell
        cell.classModel = dataSource[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let classModel = dataSource[indexPath.row]
        switch articleType {
        case .article:
            let listVC = HomeListController(listType: .article, classType: classModel.type)
            listVC.title = classModel.title
            self.navigationController?.pushViewController(listVC, animated: true)
        case .picture:
            let listVC = HomeListController(listType: .pic, classType: classModel.type)
            listVC.title = classModel.title
            self.navigationController?.pushViewController(listVC, animated: true)
        default:
            let listVC = HomeListController(listType: .article, classType: classModel.type)
            self.navigationController?.pushViewController(listVC, animated: true)
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (ScreenWidth - 12*2 - 10)/2
        return CGSize(width: cellWidth, height: cellWidth * 0.6)
    }
    
}
