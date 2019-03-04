//
//  CommentInputV.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/2/19.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

typealias SendCompletion = () -> Void

class CommentInputV: UIView {

    var sendCompletion: SendCompletion?
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var inputTextV: UITextView!
    @IBOutlet weak var placeholder: UILabel!
    
    @IBAction func sendAction(_ sender: UIButton) {
        sendCompletion?()
        //发送请求
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.width = ScreenWidth
        self.height = 70
        inputTextV.delegate = self
        inputTextV.isScrollEnabled = false //防止textView输入跳动
    }

}

extension CommentInputV: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholder.isHidden = textView.text.count > 0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = textView.text.count > 0
        sendBtn.isEnabled = textView.text.count > 0
        
        let frame = textView.frame
        let constraintSize = CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude)
        let size = textView.sizeThatFits(constraintSize)

        let maxHeight: CGFloat = 80
        let marginHeight: CGFloat = 18*2

        inputTextV.isScrollEnabled = size.height >= maxHeight
        textView.height = size.height > maxHeight ? maxHeight : size.height
        
        UIView.animate(withDuration: 0.2) {
            self.height = CGFloat(ceilf(Float(textView.height))) + marginHeight
            self.bottom = CGFloat(ceilf(Float((self.superview?.bottom)!)))
        }

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholder.isHidden = textView.text.count > 0
    }
    
    
}
