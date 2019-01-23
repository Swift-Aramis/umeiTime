//
//  MGroupCollectionController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/16.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

private let reuseIdentifier = R.nib.mGroupCollectionCell.name

class MGroupCollectionController: UICollectionViewController {

    weak var delegate: PageViewDelegate?

    convenience init(pageDelegate: PageViewDelegate) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 13, bottom: 10, right: 13)
        let itemW = (ScreenWidth - 10*2 - 13*2)/3
        let itemH = itemW * 1.45
        flowLayout.itemSize = CGSize(width: ceil(itemW - 1), height: ceil(itemH))
        self.init(collectionViewLayout: flowLayout)
        
        self.delegate = pageDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView!.register(UINib(resource: R.nib.mGroupCollectionCell), forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK: - 实现滚动代理
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.pageViewDidScroll(scrollView: scrollView)
    }

}



