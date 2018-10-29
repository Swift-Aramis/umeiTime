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
        self.kf.setImage(with: url, placeholder: placeholderImage)
    }
}
