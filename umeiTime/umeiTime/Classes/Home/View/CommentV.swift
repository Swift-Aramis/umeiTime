//
//  CommentV.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/31.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

class CommentBtn: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.top = 8
        imageView?.left = (self.width - (imageView?.width)!)/2
        titleLabel?.top = (imageView?.bottom)! + 6
        titleLabel?.left = 0
        titleLabel?.width = self.width
    }
}

typealias CollectAction = (_ collected: Bool) -> Void
typealias ShareAction = () -> Void
class CommentV: UIView {
    
    @IBOutlet weak var avatarImgV: UIImageView!
    @IBOutlet weak var collectBtn: CommentBtn!
    @IBOutlet weak var shareBtn: CommentBtn!
    @IBOutlet weak var inputTF: UITextField!
    
    var collectAction: CollectAction?
    var shareAction: ShareAction?
    
    @IBAction func collectAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.5, options: [.curveEaseOut], animations: {
                sender.imageView?.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
            }, completion: { _ in
                sender.imageView?.transform = CGAffineTransform.identity
            })
        }
        
        self.collectAction?(sender.isSelected)
//        ArticleApi.favArticle(uid: 1, aid: <#T##Int#>, which: <#T##UMArticleType#>, liked: <#T##UMArticleLiked#>)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        self.shareAction?()
    }
    
    private lazy var commentInputV: CommentInputV = {
        let commentInputV = CommentInputV.loadViewFromNib() as! CommentInputV
        commentInputV.sendCompletion = { [weak self] in
            self?.endInput()
        }
        return commentInputV
    }()

    private lazy var maskV: UIView = {
        let maskV = UIView()
        maskV.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        maskV.frame = ScreenBounds
        return maskV
    }()
    
    private lazy var inputContainerV: UIView = {
        let view = UIView()
        view.frame = ScreenBounds
        view.addTapGesture(handler: { [weak self] (tap) in
            self?.endInput()
        })
        view.addSubview(commentInputV)
        commentInputV.left = 0
        commentInputV.bottom = view.bottom
        return view
    }()
    
    private func endInput() {
        self.endEditing(true)
        inputTF.text = ""
        inputTF.resignFirstResponder()
        maskV.removeFromSuperview()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = ScreenWidth
        self.height = 50

        inputTF.delegate = self
        inputTF.inputAccessoryView = inputContainerV
        inputTF.tintColor = UIColor.clear //去掉光标颜色
    }
    
}

extension CommentV: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        UIApplication.shared.keyWindow?.addSubview(maskV)
        return true
    }
}
