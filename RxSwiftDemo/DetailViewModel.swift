//
//  DetailViewModel.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/21.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import RxSwift
import Moya


class DetailViewModel {
    
    private let provider = RxMoyaProvider<AccountService>()
    
    func getPosts() -> Observable<[Post]> {
        return provider.request(AccountService.testPost).filterSuccessfulStatusCodes().mapJSON().mapArray(type: Post.self)
    }
    
    func createPost(title: String, body: String, userId: Int) -> Observable<Post> {
        return provider.request(.testPost).mapJSON().mapObject(type: Post.self)
    }
    
    /*
    func getUsers() {
        
        return Observable.create{ (observer) -> Disposable in
            let usrs = [User(f)]
            
            return AnoumousDisposable
        }
    }
     */
}
