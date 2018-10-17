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
    @IBOutlet weak var bgImgV: UIImageView! {
        didSet {
            bgImgV.contentMode = .scaleAspectFill
            bgImgV.clipsToBounds = true
        }
    }
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
        let attentionListVC = UserListController(title: "关注")
        self.parentViewController?.navigationController?.pushViewController(attentionListVC, animated: true)
    }
    
    @IBAction func fansBtnAction(_ sender: UIButton) {
        let attentionListVC = UserListController(title: "粉丝")
        self.parentViewController?.navigationController?.pushViewController(attentionListVC, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = ScreenWidth
        self.height += NavBarHeight
    }
}
