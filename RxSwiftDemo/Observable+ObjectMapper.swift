//
//  Observable+ObjectMapper.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/21.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

extension Observable {
    
    func mapObject<T:Mappable>(type: T.Type) -> Observable<T>{
        return self.map { respones in
            guard let dict = respones as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { respones in
            
            guard let array = respones as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)!
            
        }
    }
    
}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error {}
