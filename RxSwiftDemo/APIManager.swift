//
//  APIManager.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/18.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import Moya

enum AccountService {
    case login(phoneNum: NSInteger, password: NSInteger)
    case loginout
    case testGet
    case testPost
}

let ServiceBaseURL: String = "http://jsonplaceholder.typicode.com"

extension AccountService: TargetType {
    
    /// The target's base `URL`.
    public var baseURL: URL {
        
        return URL(string: ServiceBaseURL)!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
    
        switch self {
        case .login(_, _):
            return "accountService/login"
        case .loginout:
            return "accountService/logout"
        case .testGet:
            return "posts/1"
        case .testPost:
            return "posts"
        default:
            return "posts/1"
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
    
        switch self {
        case .login(_, _):
            return .post
        case .loginout:
            return .get
        case .testGet:
            return .get
        case .testPost:
            return .post
        default:
            return .post
        }
    
    }
    
    /// The parameters to be encoded in the request.
    public var parameters: [String : Any]? {
    
        switch self {
        case .login(let phoneNum, let password):
            return ["phoneNum": phoneNum, "password": password]
        case .loginout:
            return ["login": "userId"]
        case .testPost:
            return ["title": "title", "body": "body", "userId": 1]
        default:
            return ["login": "userId"]
        }
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    /// The type of HTTP task to be performed.
    public var task: Moya.Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
        return false
    }
}
