//
//  ProfileView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/11.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var bgImgV: UIImageView!
    @IBOutlet weak var dimmingImgV: UIImageView! {
        didSet {
            dimmingImgV.image = UIImage(startColor: Color.black.withAlphaComponent(0.0), endColor: Color.black.withAlphaComponent(0.3), size: dimmingImgV.size)
        }
    }
    @IBOutlet weak var avatarImgV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signatureLabel: UILabel!
    
    @IBOutlet weak var attentionBtn: UIButton!
    @IBOutlet weak var fansBtn: UIButton!
    
    @IBAction func attentionBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func fansBtnAction(_ sender: UIButton) {
    }
}
