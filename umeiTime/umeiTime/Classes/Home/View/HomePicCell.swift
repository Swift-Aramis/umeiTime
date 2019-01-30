//
//  HomePicCell.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/9/30.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class HomePicCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var lookBtn: UIButton!
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.addShadow(ofColor: Color(hexString: "#BEBDBD")!, radius: 3, offset: CGSize(width: 0, height: 2), opacity: 0.45)
        }
    }
    
    @IBOutlet weak var imgV: UIImageView! {
        didSet {
            imgV.roundCorners([.topRight, .bottomRight], radius: 10)
        }
    }
    
    var picModel = ArticleListModel() {
        didSet {
            imgV.setImage(with: picModel.cover)
            titleLabel.text = picModel.title
            tagLabel.text = "#" + picModel.author + "#"
            lookBtn.setTitle(picModel.lookNum, for: .normal)
        }
    }

    
}
