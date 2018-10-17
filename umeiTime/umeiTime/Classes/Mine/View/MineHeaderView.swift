//
//  MineHeaderView.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/8.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MineHeaderView: UIView {

    @IBOutlet weak var avatarImgV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signatureLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel! {
        didSet {
            profileLabel.roundCorners([.topLeft, .bottomLeft], radius: profileLabel.height/2)
            profileLabel.addTapGesture { [weak self] _ in
                self?.parentViewController?.navigationController?.pushViewController(ProfileController(), animated: true)
            }
        }
    }
    @IBOutlet weak var murmurNumLabel: UILabel!
    @IBOutlet weak var attentionNumLabel: UILabel!
    @IBOutlet weak var fansNumLabel: UILabel!
    @IBOutlet weak var murmurView: UIView! {
        didSet {
            murmurView.addTapGesture { _ in
                
            }
        }
    }
    @IBOutlet weak var attentionView: UIView! {
        didSet {
            attentionView.addTapGesture { [weak self] _ in
                let attentionListVC = UserListController(title: "关注")
                self?.parentViewController?.navigationController?.pushViewController(attentionListVC, animated: true)
            }
        }
    }
    @IBOutlet weak var fansView: UIView! {
        didSet {
            fansView.addTapGesture { [weak self] _ in
                let attentionListVC = UserListController(title: "粉丝")
                self?.parentViewController?.navigationController?.pushViewController(attentionListVC, animated: true)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = ScreenWidth
    }
    
}
