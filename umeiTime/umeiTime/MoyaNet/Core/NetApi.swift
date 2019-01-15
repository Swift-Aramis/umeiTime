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

enum ResultType {
    case model
    case array
    case none
}

extension NetTarget {
    
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
                    //如果数据返回成功则直接将结果转为JSON
                    _ = try response.filterSuccessfulStatusCodes()
//                    let json = try response.mapJSON()
                    successCallback(response)
                }
                catch let error {
                    //如果数据获取失败，则返回错误状态码
                    errorCallback((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                //如果连接异常，则返回错误信息（必要时还可以将尝试重新发起请求）
                //if target.shouldRetry {
                //    retryWhenReachable(target, successCallback, errorCallback,
                //      failureCallback)
                //}
                //else {
                failureCallback(error)
                //}
            }
        }
    }

    //MARK: - result - model
    static func modelResultRequest<T: HandyJSON>(_ target:Self,
                                           _ type: T.Type,
                                           atKeyPath keyPath: String = "",
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
                                           atKeyPath keyPath: String = "",
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
