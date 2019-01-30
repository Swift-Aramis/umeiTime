//
//  ArticleListModel.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/23.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

struct ArticleListModel: HandyJSON {
    var aid : Int = 0
    var author : String = ""
    var commentcount : Int = 0
    var cover : String = ""
    var createdate : String = ""
    var html : String = ""
    var likecount : String = "0"
    var liked : Int = 0 
    var readcount : Int = 0
    var title : String = ""
    var type : String = ""
    
    var lookNum : String {
        guard let like = Int(likecount) else { return String(RandomNumber.lookNum)}
        return String(RandomNumber.lookNum + like)
    }
    
}
