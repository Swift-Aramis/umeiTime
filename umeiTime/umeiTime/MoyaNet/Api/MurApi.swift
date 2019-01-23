//
//  MurApi.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/23.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

enum UMMurType: Int {
    case text = 1, pic, music, article, book, radio, link
}

enum UMFriendType: Int {
    case following, follower
    
    
}

/**
 " {"weiyu": "{uid: "", userName: "", isShow: "", c_id: "", type: "", image: "", content: ""}" }"
 
 ["weiyu": model] -> handyJson
 
 public int uid;//用户id
 public String userName;
 public int c_id;//标签id
 public String isShow;//是否公开 1公开 0自己可见
 public int type;//类型 1 文字 2图片 3音乐 4文章 5图书 6电台 7链接
 public String image;//图片地址多张图，号分割
 public String content;//内容
 */

enum MurApi {
    case murList(uid: Int, page: Int, cid: Int)
    case myFriendList(uid: Int, page: Int)
    case userFriendList(uid: Int, userid: Int, type: UMFriendType, page: Int)
    case userChannelList(uid: Int, userid: Int, page: Int)
    case userMurChannelList(uid: Int, userid: Int, cid: Int, page: Int)
    case myMusicMurList(uid: Int, userid: Int, page: Int)
    case userMurList(uid: Int, userid: Int, page: Int)
    case murInfo(uid: Int, id: Int)
    case commentList(userid: Int, id: Int, page: Int)
    case zanList(uid: Int, wid: Int, page: Int)
    case reportComment(uid: Int, toid: Int, cid: Int, wid: Int, type: Int)
    case addComment(uid: Int, comment: String)
    case deleteComment(uid: Int, id: Int, dataId: Int)
    case searchUserZanList(uid: Int, userid: Int, keyWord: String, page: Int)
    case searchMurList(uid: Int, userid: Int, keyWord: String, page: Int)
    case readed(id: Int)
    case deleteMur(uid: Int, id: Int)
    case follow(uid: Int, userid: Int, follow: Int)
    case followedUserMurList(uid: Int, page: Int)
    case msgCommentList(uid: Int, page: Int)
    case msgNoticeList(uid: Int, page: Int)
    case msgZanList(uid: Int, page: Int)
    case userZanMurList(uid: Int, userid: Int, page: Int)
    case pubMur(umeitime: String)
    case reportMur(uid: Int, toid: Int, wid: Int, type: Int)
    case zanMur(uid: Int, toid: Int, dataId: Int, status: Int)
}

extension MurApi: NetTarget {
    
    var path: String {
        switch self {
        case .murList:
            return "getHomeWeiyuList"
        case .myFriendList:
            return "getMyFriend"
        case .userFriendList:
            return "getUserFriendList"
        case .userChannelList:
            return "getUserChannelList"
        case .userMurChannelList:
            return "getUserChannelWeiyuList"
        case .myMusicMurList:
            return "getUserMp3WeiyuList"
        case .userMurList:
            return "getUserWeiyuList"
        case .murInfo:
            return "getWeiyu"
        case .commentList:
            return "getWyCommentList"
        case .zanList:
            return "getWyZanList"
        case .reportComment:
            return "reportWyComment"
        case .addComment:
            return "user/addComment"
        case .deleteComment:
            return "user/delComment"
        case .searchUserZanList:
            return "searchUserZanWeiyuList"
        case .searchMurList:
            return "searchWeiyuList"
        case .readed:
            return "updateReadNum"
        case .deleteMur:
            return "user/delWeiyu"
        case .follow:
            return "user/followStatus"
        case .followedUserMurList:
            return "user/getDyWeiyuList"
        case .msgCommentList:
            return "user/getMsgCommentList"
        case .msgNoticeList:
            return "user/getMsgNoticeList"
        case .msgZanList:
            return "user/getMsgZanList"
        case .userZanMurList:
            return "user/getUserZanWeiyuList"
        case .pubMur:
            return "user/pubWeiyu"
        case .reportMur:
            return "user/reportWeiyu"
        case .zanMur:
            return "user/zanWeiyu"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .murList(uid: let uid, page: let page, cid: let cid):
            return ["uid": uid, "page": page, "cid": cid]
        case .myFriendList(uid: let uid, page: let page):
            return ["uid": uid, "page": page]
        case .userFriendList(uid: let uid, userid: let userid, type: let type, page: let page):
            return ["uid": uid, "userid": userid, "type": type, "page": page]
        case .userChannelList(uid: let uid, userid: let userid, page: let page):
            return ["uid": uid, "userid": userid, "page": page]
        case .userMurChannelList(uid: let uid, userid: let userid, cid: let cid, page: let page):
            return ["uid": uid, "userid": userid, "cid": cid, "page": page]
        case .myMusicMurList(uid: let uid, userid: let userid, page: let page):
            return ["uid": uid, "userid": userid, "page": page]
        case .userMurList(uid: let uid, userid: let userid, page: let page):
            return ["uid": uid, "userid": userid, "page": page]
        case .murInfo(uid: let uid, id: let id):
            return ["uid": uid, "id": id]
        case .commentList(userid: let userid, id: let id, page: let page):
            return ["userid": userid, "id": id, "page": page]
        case .zanList(uid: let uid, wid: let wid, page: let page):
            return ["uid": uid, "wid": wid, "page": page]
        case .reportComment(uid: let uid, toid: let toid, cid: let cid, wid: let wid, type: let type):
            return ["uid": uid, "toid": toid, "cid": cid, "wid": wid, "type": type]
        case .addComment(uid: let uid, comment: let comment):
            return ["uid": uid, "comment": comment]
        case .deleteComment(uid: let uid, id: let id, dataId: let dataId):
            return ["uid": uid, "id": id, "dataId": dataId]
        case .searchUserZanList(uid: let uid, userid: let userid, keyWord: let keyWord, page: let page):
            return ["uid": uid, "userid": userid, "keyWord": keyWord, "page": page]
        case .searchMurList(uid: let uid, userid: let userid, keyWord: let keyWord, page: let page):
            return ["uid": uid, "userid": userid, "keyWord": keyWord, "page": page]
        case .readed(id: let id):
            return ["id": id]
        case .deleteMur(uid: let uid, id: let id):
            return ["uid": uid, "id": id]
        case .follow(uid: let uid, userid: let userid, follow: let follow):
            return ["uid": uid, "userid": userid, "follow": follow]
        case .followedUserMurList(uid: let uid, page: let page):
            return ["uid": uid, "page": page]
        case .msgCommentList(uid: let uid, page: let page):
            return ["uid": uid, "page": page]
        case .msgNoticeList(uid: let uid, page: let page):
            return ["uid": uid, "page": page]
        case .msgZanList(uid: let uid, page: let page):
            return ["uid": uid, "page": page]
        case .userZanMurList(uid: let uid, userid: let userid, page: let page):
            return ["uid": uid, "userid": userid, "page": page]
        case .pubMur(umeitime: let umeitime):
            return ["umeitime": umeitime]
        case .reportMur(uid: let uid, toid: let toid, wid: let wid, type: let type):
            return ["uid": uid, "toid": toid, "wid": wid, "type": type]
        case .zanMur(uid: let uid, toid: let toid, dataId: let dataId, status: let status):
            return ["uid": uid, "toid": toid, "dataId": dataId, "status": status]
        }
    }
}

