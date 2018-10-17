//
//  MGroupCollectionCell.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/16.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MGroupCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addShadow(ofColor: Color(hexString: "#BEBDBD")!, radius: 3, offset: CGSize(width: 0, height: 2), opacity: 0.45)
    }

}
