//
//  HomeArticleCell.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomeArticleCell: UITableViewCell {

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var lookBtn: UIButton!
    
    var articleModel = ArticleListModel() {
        didSet {
            imgV.setImage(with: articleModel.cover)
            titleLabel.text = articleModel.title
            tagLabel.text = "#" + articleModel.author + "#"
            lookBtn.setTitle(articleModel.lookNum, for: .normal)
        }
    }

}
