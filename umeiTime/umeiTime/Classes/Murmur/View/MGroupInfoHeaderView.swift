//
//  MGroupInfoHeaderView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/16.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MGroupInfoHeaderView: UIView {

    @IBOutlet weak var bgImgV: UIImageView! {
        didSet {
            bgImgV.contentMode = .scaleAspectFill
            bgImgV.clipsToBounds = true
        }
    }
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = ScreenWidth
        self.height += NavBarHeight
        contentHeight.constant = self.height
    }

}
