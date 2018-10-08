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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        setupCollectionView()
    }

}

extension HomeClassController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        collectionView.register(R.nib.homeClassCell(), forCellWithReuseIdentifier: R.nib.homeClassCell.name)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeClassCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.homeClassCell.name, for: indexPath) as! HomeClassCell
        
        // Configure the cell
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (ScreenWidth - 12*2 - 10)/2
        return CGSize(width: cellWidth, height: cellWidth * 0.6)
    }
    
}
