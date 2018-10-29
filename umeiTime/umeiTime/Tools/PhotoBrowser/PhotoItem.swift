//
//  PhotoItem.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/23.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class PhotoItem: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scrollV)
        scrollV.addSubview(imageV)
        contentView.addSubview(errorLabel)
        contentView.addSubview(loadingV)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
//            print("1 秒后输出")
//            self.testProgress()
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollV.frame = contentView.bounds
        adjustimageV()
        errorLabel.center = contentView.center
        loadingV.center = contentView.center
    }
    
    private func adjustimageV() {
        
        guard let imageSize = imageV.image?.size else {
            return
        }
        
        let ajustHeight = scrollV.width * (imageSize.height / imageSize.width)
        imageV.size = CGSize(width: scrollV.width, height: ajustHeight)
        imageV.center = CGPoint(x: scrollV.width/2, y: scrollV.height/2)

        //超大图处理
        if ajustHeight > scrollV.height {
            imageV.y = 0
            scrollV.contentSize = imageV.size
        }
    }
    
    //MARK: - Var
    private var progress: CGFloat = 0.0 {
        didSet {
            self.loadingV.progress = progress
        }
    }
    
    private lazy var loadingV: BrowserLoadingView = {
        let loadingView = BrowserLoadingView()
        loadingView.mode = PhotoBrowserConfig.shared.loadingMode
        loadingView.size = CGSize(width: 100, height: 100)
        loadingView.isHidden = true
        return loadingView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "图片加载失败"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        label.size = CGSize(width: 160, height: 30)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()
    
    private lazy var scrollV: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = PhotoBrowserConfig.shared.browserBgColor
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        //设置缩放范围
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 1.0
        return scrollView
    }()
    
    private lazy var imageV: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        // 单击图片
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapAction))
        // 双击放大图片
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        // 防止冲突
        singleTap.require(toFail: doubleTap)
        imageView.addGestureRecognizer(singleTap)
        imageView.addGestureRecognizer(doubleTap)
        
        return imageView
    }()
}

//FIXME: - ForTest
extension PhotoItem {
    private func testProgress() {
        self.loadingV.isHidden = false
        
        let skipBtnTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        skipBtnTimer.schedule(deadline: .now(), repeating: 1.0)
        skipBtnTimer.setEventHandler(handler: { [weak self] in
            
            DispatchQueue.main.async {
                self?.progress += 0.1
                print(self?.progress ?? "0.00")
            }
            
            if (self?.progress)! >= CGFloat(1) {
                skipBtnTimer.cancel()
            }
        })
        skipBtnTimer.resume()
    }
}

//MARK: - 缩放大小
extension PhotoItem: UIScrollViewDelegate {
    
    private func clearZoom() {
        scrollV.setZoomScale(1, animated: false)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageV
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //图片加载中 || 图片错误 -> 取消捏合效果
        guard loadingV.isHidden || errorLabel.isHidden else {
            return
        }
        
        var xCenter = scrollView.center.x
        var yCenter = scrollView.center.y
        xCenter = scrollView.contentSize.width > scrollView.width ? scrollView.contentSize.width/2 : xCenter
        yCenter = scrollView.contentSize.height > scrollView.height ? scrollView.contentSize.height/2 : yCenter
        imageV.center = CGPoint(x: xCenter, y: yCenter)
    }
    
}

//MARK: - TapAction
extension PhotoItem {
    
    @objc private func singleTapAction(_ tapG: UITapGestureRecognizer) {
        guard loadingV.isHidden else {
            return
        }
        
        if scrollV.zoomScale > 1 {
            //图片错误 -> 取消单击调整图片效果
            guard errorLabel.isHidden else {
                return
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.scrollV.setZoomScale(1, animated: false)
            }, completion: nil)
            
        } else { //取消预览大图
            // 关闭viewController
            if let _ = self.parentViewController?.presentingViewController {
                self.parentViewController?.dismiss(animated: true, completion: nil)
            } else {
                self.parentViewController?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func doubleTapAction(_ tapG: UITapGestureRecognizer) {
        //图片加载中 || 图片错误 -> 取消双击手势
        guard loadingV.isHidden || errorLabel.isHidden else {
            return
        }
        
        if scrollV.zoomScale > 1 { //恢复大小
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.scrollV.setZoomScale(1, animated: false)
            }, completion: nil)
            
        } else { //放大图片
            let location = tapG.location(in: tapG.view)

            let w = scrollV.width/scrollV.maximumZoomScale
            let h = scrollV.height/scrollV.maximumZoomScale
            let x = location.x - (w / 2)
            let y = location.y - (h / 2)
            
            let rect = CGRect(x: x, y: y, width: w, height: h)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.scrollV.zoom(to: rect, animated: false)
            }, completion: nil)
        }
    }
}

//MARK: - PublicHelper
extension PhotoItem {
    
    func setImage(with urlString: String, placeholderImage: UIImage) {
        //FIXME: - 本地图片
//        imageV.contentMode = .scaleAspectFit
        imageV.image = placeholderImage
        
        //FIXME: - 网络图片
        print("PhotoItem - urlString === \(urlString)")
//        imageV.contentMode = .scaleAspectFit
//        let url = URL.init(string: urlString)
//        imageV.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(1))], progressBlock: {[weak self] (receivedSize, totalSize) in
//            self?.loadingV.isHidden = false
//            self?.progress = CGFloat(receivedSize/totalSize)
//            print("progressBlock: \(receivedSize)/\(totalSize)")
//        }, completionHandler: {[weak self] (image, error, cacheType, imageURL) in
//            if let _ = error {
//                self?.errorLabel.isHidden = false
//            }
//        })
    }
    
    //FIXME: - reset
    func reset() {
        progress = 0
        loadingV.isHidden = true
        errorLabel.isHidden = true
        clearZoom()
    }
}









