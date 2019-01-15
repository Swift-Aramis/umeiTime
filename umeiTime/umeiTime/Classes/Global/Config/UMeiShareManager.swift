//
//  UMConfig.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/7.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

let UM_APP_KEY = "5c32f7ccb465f558fb0016e7"
let UM_CHANNEL = "UMeiTime APP Store"
let WECHAT_APP_ID = "wxed543eeb23fc3a9c"
let WECHAT_APP_SECRET = "19a1798395ea5b3b5d85e9611809297d"
let QQ_APP_ID = "1101163529"
let QQ_APP_KEY = "fkIXHGuxWwBvJI3T"
let WEIBO_APP_KEY = "2635009755"
let WEIBO_APP_SECRET = ""

class UMeiShareManager: NSObject {
    
    static func configUM() {
        UMConfigure.initWithAppkey(UM_APP_KEY, channel: UM_CHANNEL)
        
        configUSharePlatforms()
    }
    
    
    /// 配置分享平台
    static func configUSharePlatforms() {
        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.wechatTimeLine, appKey: WECHAT_APP_ID, appSecret: WECHAT_APP_SECRET, redirectURL: nil)
        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.QQ, appKey: QQ_APP_KEY, appSecret: nil, redirectURL: nil)
        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.sina, appKey: WEIBO_APP_KEY, appSecret: WEIBO_APP_SECRET, redirectURL: "https://sns.whalecloud.com/sina2/callback")
 
    }
    
    
    
}
