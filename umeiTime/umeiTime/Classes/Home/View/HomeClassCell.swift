//
//  HomeClassCell.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/5.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomeClassCell: UICollectionViewCell {

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var classModel = ArticleClassModel() {
        didSet {
            imgV.setImage(with: classModel.image)
            titleLabel.text = classModel.title
        }
    }
    
}
