//
//  MsgListCell.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/29.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MsgListCell: UITableViewCell {

    @IBOutlet weak var avatarImgV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var contentImgV: UIImageView! {
        didSet {
            contentImgV.isHidden = true
        }
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        avatarImgV.backgroundColor = UIColor.groupTableViewBackground
        contentImgV.backgroundColor = UIColor.groupTableViewBackground
        contentLabelBgView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        avatarImgV.backgroundColor = UIColor.groupTableViewBackground
        contentImgV.backgroundColor = UIColor.groupTableViewBackground
        contentLabelBgView.backgroundColor = UIColor.groupTableViewBackground
    }
    
}
