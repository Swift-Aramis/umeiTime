//
//  ArticleApi.swift
//  umeiTime
//
//  Created by 提运佳 on 2019/1/23.
//  Copyright © 2019 提运佳. All rights reserved.
//

import UIKit

enum UMArticleType: Int {
    case article = 1, radio, picture
}

enum UMArticleLiked: Int {
    case liked, unLiked
}

enum ArticleApi {
    case allList(which: UMArticleType, page: Int)
    case commentList(aid: Int, which: UMArticleType, page: Int)
    case articleContent(uid: Int, aid: Int, which: UMArticleType)
    case articleList(uid: Int, type: String, which: UMArticleType, page: Int)
    case catalogList(uid: Int, which: UMArticleType)
    case pubArticle(article: String)
    case pubPicArticle(article: String)
    case reportComment(uid: Int, toid: Int, cid: Int, type: Int)
    case addComment(uid: Int, comment: String)
    case deleteComment(uid: Int, id: Int, dataId: Int, which: UMArticleType)
    case searchArticle(uid: Int, keyWord: String, which: UMArticleType, page: Int)
    case favArticle(uid: Int, aid: Int, which: UMArticleType, liked: UMArticleLiked)
    case userFavedArticleList(uid: Int, which: UMArticleType, page: Int)
}

extension ArticleApi: NetTarget {
    
    var path: String {
        switch self {
        case .allList:
            return "getAllArticleList"
        case .commentList:
            return "getArticleCommentList"
        case .articleContent:
            return "getArticleContent"
        case .articleList:
            return "getArticleList"
        case .catalogList:
            return "getCatalogList"
        case .pubArticle:
            return "pubArticle"
        case .pubPicArticle:
            return "pubPicArticle"
        case .reportComment:
            return "reportArticleComment"
        case .addComment:
            return "user/addArticleComment"
        case .deleteComment:
            return "user/delArticleComment"
        case .searchArticle:
            return "searchArticle"
        case .favArticle:
            return "user/favArticle"
        case .userFavedArticleList:
            return "user/getFavArticleList"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .allList(which: let which, page: let page):
            return ["which": which, "page": page]
        case .commentList(aid: let aid, which: let which, page: let page):
            return ["aid": aid, "which": which, "page": page]
        case .articleContent(uid: let uid, aid: let aid, which: let which):
            return ["uid": uid, "aid": aid, "which": which]
        case .articleList(uid: let uid, type: let type, which: let which, page: let page):
            return ["uid": uid, "type": type, "which": which, "page": page]
        case .catalogList(uid: let uid, which: let which):
            return ["uid": uid, "which": which]
        case .pubArticle(article: let article):
            return ["article": article]
        case .pubPicArticle(article: let article):
            return ["article": article]
        case .reportComment(uid: let uid, toid: let toid, cid: let cid, type: let type):
            return ["uid": uid, "toid": toid, "cid": cid, "type": type]
        case .addComment(uid: let uid, comment: let comment):
            return ["uid": uid, "comment": comment]
        case .deleteComment(uid: let uid, id: let id, dataId: let dataId, which: let which):
            return ["uid": uid, "id": id, "dataId": dataId, "which": which]
        case .searchArticle(uid: let uid, keyWord: let keyWord, which: let which, page: let page):
            return ["uid": uid, "keyWord": keyWord, "which": which, "page": page]
        case .favArticle(uid: let uid, aid: let aid, which: let which, liked: let liked):
            return ["uid": uid, "aid": aid, "which": which, "liked": liked.rawValue]
        case .userFavedArticleList(uid: let uid, which: let which, page: let page):
            return ["uid": uid, "which": which, "page": page]
        }
    }
}
