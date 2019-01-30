//
//  NetApi.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/12/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import SwiftyJSON

enum ResultType {
    case model
    case array
    case none
}

struct ResultModel: HandyJSON {
    var code: Int?
    var msg: String?
}

extension NetTarget {
    
    static func provider() -> MoyaProvider<Self> {
        return NetWrapper.provider()
    }
    
    //MARK: - request
    static func request(_ target: Self,
                        success successCallback: @escaping (Response) -> Void,
                        error errorCallback: @escaping (Int) -> Void,
                        failure failureCallback: @escaping (MoyaError) -> Void)
    {
        provider().request(target) { result in
            switch result {
            case let .success(response):
                
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let json = try response.mapString()
                    
                    debugPrint("接口 === \(target.path) \n 参数 === \(target.parameters) 返回值 === ")
                    let sJson = JSON.init(parseJSON: json)
                    debugPrint(sJson.dictionary as Any)
                    
                    if let result: ResultModel =  ResultModel.deserialize(from: json),
                        let msg = result.msg,
                        let code = result.code,
                        code != 200 {
                        HUD.showMessage(msg)
                        errorCallback(result.code ?? 0)
                        return
                    }
                    
                    successCallback(response)
                }
                catch let error {
                    //如果数据获取失败，则返回错误状态码
                    HUD.showMessage("请求错误")
                    errorCallback((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                //如果连接异常，则返回错误信息（必要时还可以将尝试重新发起请求）
                //if target.shouldRetry {
                //    retryWhenReachable(target, successCallback, errorCallback,
                //      failureCallback)
                //}
                //else {
                HUD.showMessage("网络错误")
                failureCallback(error)
                //}
            }
        }
    }

    //MARK: - result - model
    static func modelResultRequest<T: HandyJSON>(_ target:Self,
                                           _ type: T.Type,
                                           atKeyPath keyPath: String = "data",
                                           successHandler: @escaping (T?) -> Void,
                                           errorHandler: @escaping (Int) -> Void)
    {
        
        self.request(target, success: { (response) in
            let model = try? response.map(T.self, atKeyPath: keyPath)
            successHandler(model)
            
        }, error: { (errorCode) in
            errorHandler(errorCode)
            
        }, failure: {_ in
            //网络问题
        })
    }
    
    //MARK: - result - array
    static func arrayResultRequest<T: HandyJSON>(_ target:Self,
                                           _ type: [T].Type,
                                           atKeyPath keyPath: String = "data",
                                           successHandler: @escaping ([T]?) -> Void,
                                           errorHandler: @escaping (Int) -> Void) {
        self.request(target, success: { (response) in
            let array = try? response.map([T].self, atKeyPath: keyPath)
            successHandler(array)
            
        }, error: { (errorCode) in
            errorHandler(errorCode)
        
        }, failure: {_ in
            //网络问题
        })
    }
    
    //MARK: - result - none
    static func noneResultRequest(_ target:Self,
                                    successHandler: @escaping () -> Void,
                                    errorHandler: @escaping (Int) -> Void) {
        self.request(target, success: { (response) in
            successHandler()
            
        }, error: { (errorCode) in
            errorHandler(errorCode)
            
        }, failure: {_ in
            //网络问题
        })
    }
    
}
