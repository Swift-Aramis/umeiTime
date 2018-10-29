//
//  PhotoBrowser.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/23.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

struct PhotoModel {
    var placeholderImage = UIImage()
    var imageURL: String = ""
}

//MARK: - PublicHelper
extension PhotoBrowser {
    
    enum PhotoBrowserShowType {
        case present
        case push
    }
    
    //展示方法
    static func showPhotoBrowser(from vc: UIViewController, type: PhotoBrowserShowType = .present, photos: [PhotoModel], index: Int = 0) {
        let browser = PhotoBrowser()
        browser.photoModels = photos
        browser.currentIndex = index
        if type == .present {
            vc.present(browser, animated: false, completion: nil)
        } else {
            vc.navigationController?.pushViewController(browser, animated: true)
        }
    }
}

private let reuseIdentifier = "PhotoBrowserItem"
class PhotoBrowser: UIViewController {
    
    var photoModels = [PhotoModel]() {
        didSet {
            pageControl.numberOfPages = photoModels.count
            collectionView.reloadData()
        }
    }
    
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    var photoSpacing: CGFloat = 30

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToItem(at: currentIndex, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.frame.size.width = view.bounds.width + photoSpacing
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: photoSpacing)
        pageControl.frame = CGRect(x: 0, y: view.height - 40, width: view.width, height: 40)
    }

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 30
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = UIScreen.main.bounds.size
        
        let cltV = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cltV.backgroundColor = UIColor.black
        cltV.isPagingEnabled = true
        cltV.showsHorizontalScrollIndicator = false
        
        return cltV
    }()
    
    private let pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.hidesForSinglePage = true
        return pageC
    }()
}

extension PhotoBrowser: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func setupCollectionView() {
        collectionView.register(PhotoItem.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func scrollToItem(at index: Int, animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .left, animated: animated)
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoItem = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoItem
        let photoModel = photoModels[indexPath.row]
        cell.setImage(with: photoModel.imageURL, placeholderImage: photoModel.placeholderImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let itemCell = cell as! PhotoItem
        itemCell.reset()
    }
    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
//        scrollToItem(at: currentIndex, animated: true)
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
//        scrollToItem(at: currentIndex, animated: true)
//    }

}





