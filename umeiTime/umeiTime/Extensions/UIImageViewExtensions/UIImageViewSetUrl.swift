//
//  UIImageViewSetUrl.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/23.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String?, placeholderImage: UIImage? = nil) {
        guard let url = URL(string: urlString ?? "") else {
            self.backgroundColor = UIColor.groupTableViewBackground
            return
        }
        
        let options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
        self.kf.setImage(with: url,
                         placeholder: placeholderImage,
                         options: options,
                         progressBlock: { (receivedSize, totalSize) in
            
        }, completionHandler: { (image, error, cacheType, imageURL) in
            //调整图片
            guard let img = image?.scaled(toSize: self.size) else {
                return
            }
            
            self.backgroundColor = UIColor.clear
            self.image = img
        })
    }
}
