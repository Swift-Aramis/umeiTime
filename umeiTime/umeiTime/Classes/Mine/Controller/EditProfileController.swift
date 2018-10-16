//
//  EditProfileController.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/15.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

class EditProfileController: BaseTableViewController {

    
    private lazy var dataSource: [[SystemCellModel]] = {
        var dataArray = [[SystemCellModel]]()
        let avatar = [SystemCellModel(title: "头像", subText: ""),
                      SystemCellModel(title: "主页背景", subText: "")]
        dataArray.append(avatar)

        let info = [SystemCellModel(title: "昵称", subText: "待完善"),
                    SystemCellModel(title: "性别", subText: "待完善"),
                    SystemCellModel(title: "生日", subText: "待完善"),
                    SystemCellModel(title: "地址", subText: "待完善"),
                    SystemCellModel(title: "签名", subText: "待完善")]
        dataArray.append(info)
        
        let account = [SystemCellModel(title: "QQ", subText: "去绑定"),
                       SystemCellModel(title: "微博", subText: "去绑定"),
                       SystemCellModel(title: "微信", subText: "去绑定")]
        dataArray.append(account)
        //最动听的声音叫时光
        //例如: https://weibo.com/XXXX
        return dataArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的资料"
    }
    
    override func setupTableView() {
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID: String
        var cell: UITableViewCell? = nil
        var style: UITableViewCellStyle
        if indexPath.section == 0 {
            cellID = "default"
            style = .default
        } else {
            cellID = "value1"
            style = .value1
        }
        cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: style, reuseIdentifier: cellID)
            cell?.textLabel?.font = AppFont.secendTextFont
            cell?.textLabel?.textColor = AppColor.darkBlack
            cell?.detailTextLabel?.font = AppFont.secendTextFont
            cell?.detailTextLabel?.textColor = AppColor.normalGray
        }
        
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row].title
        cell?.detailTextLabel?.text = dataSource[indexPath.section][indexPath.row].subText
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let headImgV = UIImageView()
                headImgV.backgroundColor = UIColor.groupTableViewBackground
                headImgV.size = CGSize(width: 50, height: 50)
                headImgV.avatarRadius = true
                cell?.accessoryView = headImgV
            } else {
                let bgImgV = UIImageView()
                bgImgV.backgroundColor = UIColor.groupTableViewBackground
                bgImgV.size = CGSize(width: 50, height: 50)
                cell?.accessoryView = bgImgV
            }
            
        } else {
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 50
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

}
