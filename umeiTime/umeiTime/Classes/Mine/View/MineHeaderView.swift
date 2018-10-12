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
            attentionView.addTapGesture { _ in
                
            }
        }
    }
    @IBOutlet weak var fansView: UIView! {
        didSet {
            fansView.addTapGesture { _ in
                
            }
        }
    }
    
    
    
}
