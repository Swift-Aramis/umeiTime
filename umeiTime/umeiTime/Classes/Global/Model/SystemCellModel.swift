//
//  SystemCellModel.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/10/9.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit

struct SystemCellModel {
    
    var icon = ""
    var title = ""
    var subText = ""
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
    
    init(title: String, subText: String) {
        self.title = title
        self.subText = subText
    }
    
}
