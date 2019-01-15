//
//  MoyaHandyJson.swift
//  umeiTime
//
//  Created by 提运佳 on 2018/12/28.
//  Copyright © 2018 提运佳. All rights reserved.
//

import UIKit
import Moya
import HandyJSON

public enum HandyJSONMapError: Swift.Error {
    case mapError
}

public extension Response {
    
    public func map<D: HandyJSON>(_ type: D.Type, atKeyPath keyPath: String? = nil) throws -> D {
        let jsonString = try mapString()
        if let obj = D.deserialize(from: jsonString, designatedPath: keyPath) {
            return obj
        }
        throw MoyaError.objectMapping(HandyJSONMapError.mapError, self)
    }
    
    public func map<D: HandyJSON>(_ type: [D].Type, atKeyPath keyPath: String? = nil) throws -> [D] {
        let jsonString = try mapString()
        if let objs = [D].deserialize(from: jsonString, designatedPath: keyPath) as? [D] {
            return objs
        }
        throw MoyaError.objectMapping(HandyJSONMapError.mapError, self)
    }
}
