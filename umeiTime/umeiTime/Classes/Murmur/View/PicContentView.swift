//
//  PicContentView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/19.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class PicContentView: UIView {
    
    var picPathStringsArray = [String]() {
        didSet {
            /// 隐藏多余的imgV
            for index in picPathStringsArray.count..<imageViewsArray.count {
                let imgV = imageViewsArray[index]
                imgV.isHidden = true
            }
            
            /// 0判断
            if picPathStringsArray.count == 0 {
                self.height = 0
                return
            }
        
            if picPathStringsArray.count == 1 {/// 一张图片时
                
                let singleImgV = imageViewsArray.first
                singleImgV?.isHidden = false
                singleImgV?.x = 0
                singleImgV?.y = 0
                //FIXME: - 网络图片要从后端得到图片显示大小
//                let maxW: CGFloat = 200
//                let maxH: CGFloat = 180
//                singleImgV?.size = CGSize(width: maxW, height: maxH)
                
//                DispatchQueue.global().async {
//                    let image = self.image(from: self.picPathStringsArray.first!)
//                    DispatchQueue.main.async {
//                        singleImgV?.image = image
//                        singleImgV?.fitImageViewSize(with: image)
//                        self.height = (singleImgV?.height)!
//                    }
//                }
                
                //FIXME: - 加载本地图片
                guard let image = UIImage(named: picPathStringsArray.first!) else {
                    return
                }
                singleImgV?.fitImageViewSize(with: image)
                self.height = (singleImgV?.height)!
                
            } else {/// 多张图片时
                let gap: CGFloat = 8
                let itemW = (self.width - gap*2)/3
                let itemH = itemW
                //每行的item数量
                let perRowItemCount = self.perRowItemCount(for: picPathStringsArray)
                //先定位置，再加载图片
                let columnCount = ceilf(Float(picPathStringsArray.count) / Float(perRowItemCount))
                let h = CGFloat(columnCount) * itemH + CGFloat(columnCount - 1) * gap
                self.height = h
                
                for (index, imgUrl) in picPathStringsArray.enumerated() {
                    // 列
                    let columnIndex = index % perRowItemCount
                    // 行
                    let rowIndex = index / perRowItemCount
                    
                    let imgV = imageViewsArray[index]
                    imgV.isHidden = false
                    //等比缩小，取中间显示
                    //FIXME: - 多张网络图片
//                    DispatchQueue.global().async {
//                        let image = self.image(from: imgUrl).fitSquareImageSize(with: itemW)
//                        DispatchQueue.main.async {
//                            imgV.image = image
//                        }
//                    }
                    
                    //FIXME: - 多张本地图片
//                    imgV.image = UIImage(named: imgUrl)?.fitSquareImageSize(with: itemW)
                    imgV.image = UIImage(named: imgUrl)
                    imgV.contentMode = .scaleAspectFill
                    imgV.clipsToBounds = true
                    imgV.frame = CGRect(x: CGFloat(columnIndex) * (itemW + gap),
                                        y: CGFloat(rowIndex) * (itemH + gap),
                                        width: itemW,
                                        height: itemH)
                }
            }
        }
    }
    
    //FIXME: - 加载数据耗时操作 
    private func image(from path: String) -> UIImage {
        guard let url = URL(string: path),
            let imageData = try? Data.init(contentsOf: url),
            let image = UIImage(data: imageData) else {
                return UIImage()
        }
        return image
    }
    
    /// 每行的item数量
    private func perRowItemCount(for picPathArray: [String]) -> Int {
        if picPathArray.count < 3 {
            return picPathArray.count
        } else if picPathArray.count <= 4 {
            return 2
        } else {
            return 3
        }
    }
    
    private var imageViewsArray = [UIImageView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.width = ScreenWidth - 13*2
        setupImageViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PicContentView {
    
    private func setupImageViews() {
        
        for index in 0..<9 {
            let imageV = UIImageView()
            self.addSubview(imageV)
            imageV.isUserInteractionEnabled = true
            imageV.backgroundColor = UIColor.groupTableViewBackground
            imageV.tag = index
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapImageV))
            imageV.addGestureRecognizer(gesture)
            imageViewsArray.append(imageV)
        }
    }
    
    @objc private func tapImageV(_ tap:UITapGestureRecognizer) {
        let imageV = tap.view
        let index = imageV?.tag
        print("index === \(String(describing: index))")
        guard let pControl = self.parentViewController else {
            return
        }
        
        var photos = [PhotoModel]()
        for (index, imgUrl) in picPathStringsArray.enumerated() {
            var photoModel = PhotoModel()
            photoModel.imageURL = imgUrl
            photoModel.placeholderImage = imageViewsArray[index].image ?? UIImage()
            photos.append(photoModel)
        }
        
        PhotoBrowser.showPhotoBrowser(from: pControl, type: .present, photos: photos, index: index!)
    }
    
}

//MARK: - 图片等比压缩处理
extension UIImage {
    
    public func fitSquareImageSize(with max: CGFloat) -> UIImage? {
        if self.size.width > self.size.height {//横图
            return self.scaled(toHeight: max)
        } else {//竖图
            return self.scaled(toWidth: max)
        }
    }
}

//MARK: - 单张图片时图片大小调整
//FIXME: - 需要在model里确定image的宽高，进行合理压缩显示
//fix - 单张图片情况需要后端返回图片宽高，提前确定图片大小，再填充加载
extension UIImageView {
    
    public func fitImageViewSize(with image: UIImage) {
        let originW = image.size.width
        let originH = image.size.height
        
        let maxW: CGFloat = scale(200)
        let minH: CGFloat = scale(60)
        let maxH: CGFloat = scale(180)
        let minW: CGFloat = scale(50)

        /// 图片小于限制大小
        guard originW >= minW, originH >= minH else {
            self.size = CGSize(width: scale(80), height: scale(80))
            self.contentMode = .center
            self.clipsToBounds = true
            self.backgroundColor = UIColor.groupTableViewBackground
            print("图片太小 - \(self.size)")
            return
        }
       
        /// 不需要调整大小
        if originW < maxW, originH < maxH {
            self.size = CGSize(width: originW, height: originH)
            print("不需调整图片大小 - \(self.size)")
            return
        }
        
        /// 图片大于限制大小
        var imgW: CGFloat = 0
        var imgH: CGFloat = 0
        if originW >= originH { /// 横图
            //宽度最大限制
            if originW > maxW {
                print("横图 - 图片太宽")
                imgW = maxW
                imgH = originH / originW * maxW
            
                //高度最小限制
                if imgH < minH {
                    imgH = minH
                    self.image = image.scaled(toHeight: imgH)
                    self.contentMode = .center
                    self.clipsToBounds = true
                }
            }
            
        } else { /// 竖图
            //高度最大限制
            if originH > maxH {
                print("竖图 - 图片太长")
                imgH = maxH
                imgW = originW / originH * maxH
                
                //宽度最小限制
                if imgW < minW {
                    imgW = minW
                    self.image = image.scaled(toWidth: imgW)
                    self.contentMode = .center
                    self.clipsToBounds = true
                }
            }
        }
        self.size = CGSize(width: imgW, height: imgH)
        print("调整后 - \(self.size)")
    }
    
    public func scale(_ x: CGFloat) -> CGFloat {
        return ceil(x * ScreenWidth / 375.0)
    }
    
}



