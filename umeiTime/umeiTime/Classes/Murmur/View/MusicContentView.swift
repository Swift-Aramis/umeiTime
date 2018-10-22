//
//  MusicContentView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/19.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MusicContentView: UIView {

    @IBOutlet weak var albumImgV: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel! {
        didSet {
            tagLabel.roundCorners([.topLeft, .bottomLeft], radius: tagLabel.height/2)
        }
    }
    
}
