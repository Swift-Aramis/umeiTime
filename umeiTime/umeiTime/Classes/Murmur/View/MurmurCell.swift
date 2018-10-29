//
//  MurmurCell.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/16.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class MurmurCell: UITableViewCell {

    @IBOutlet weak var centerView: UIView!
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = AppColor.darkBlack
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "一杯敬朝阳，一杯敬月光。"
        return label
    }()
    
    private var linkLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textColor = AppColor.linkBlue
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "http://umeiTime.com"
        return label
    }()
    
    private var musicView: MusicContentView = MusicContentView.loadViewFromNib() as! MusicContentView
    private var picView: PicContentView = PicContentView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addCenterContentView()
        constraintCenterContentView()
    }
    
}

extension MurmurCell {
    
    private func addCenterContentView() {
        centerView.addSubview(infoLabel)
        centerView.addSubview(linkLabel)
        centerView.addSubview(musicView)
        centerView.addSubview(picView)
    }
    
    private func constraintCenterContentView() {
        //特殊单张图片测试
//        picView.picPathStringsArray = ["电脑横屏图片.png"]
        
        //FIXME: - 需要调整，判断是否超过全屏，如果过长，横向最大限制为全屏
//        picView.picPathStringsArray = ["横向图片.png"]
//        picView.picPathStringsArray = ["宽细图片.jpg"]
        
//        picView.picPathStringsArray = ["竖屏图片.png"]
//        picView.picPathStringsArray = ["窄长图片.jpg"]

        //多张图片测试
        picView.picPathStringsArray = ["电脑横屏图片.png","test.png","test.png","test.png","test.png","test.png","test.png","test.png","test.png"]
        
        //测试网络图片
//        picView.picPathStringsArray = ["http://pic.58pic.com/58pic/14/62/50/62558PICxm8_1024.jpg",
//                                       "http://pic19.nipic.com/20120308/4970979_102637717125_2.jpg"]
        
//        picView.picPathStringsArray = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540466566825&di=39905442de5a11dcc55a204147a28e61&imgtype=0&src=http%3A%2F%2Fpic1.cxtuku.com%2F00%2F10%2F26%2Fb112bf6ff351.jpg"]
        
        constraintInfoLabel()
        
        constraintPicView()
    }
    
    private func constraintInfoLabel() {
        infoLabel.sizeToFit()
        infoLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func constraintPicView() {
        picView.isHidden = false
        musicView.isHidden = true
        linkLabel.isHidden = true
        let picGapY = infoLabel.height == 0 ? 0 : 16
        picView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(picGapY)
            make.left.right.equalToSuperview()
            make.height.equalTo(picView.height)
            make.bottom.equalToSuperview()
        }
    }
    
    private func constraintMusicView() {
        picView.isHidden = true
        musicView.isHidden = false
        linkLabel.isHidden = true
        let musicGapY = infoLabel.height == 0 ? 0 : 16
        musicView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(musicGapY)
            make.left.right.equalToSuperview()
            make.height.equalTo(musicView.height)
            make.bottom.equalToSuperview()
        }
    }
    
    private func constraintLinkLabel() {
        picView.isHidden = true
        musicView.isHidden = true
        linkLabel.isHidden = false
        let linkGapY = infoLabel.height == 0 ? 0 : 8
        linkLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(linkGapY)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}


