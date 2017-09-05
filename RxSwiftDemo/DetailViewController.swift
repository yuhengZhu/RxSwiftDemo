//
//  DetailViewController.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/18.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Moya

class DetailViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let provider = RxMoyaProvider<AccountService>()
        /*
        provider.request(.testGet) { result in
            
            switch result {
                
            case let .success(response):
                print(response)
            
            default:
                print(result)
            }
        }
        */
        
        /*
        provider.request(.testPost) { result in
            print(result)
            switch result {
                
            case let .success(response):
                print(response)
                
            default:
                print(result)
            }
        }
        */
            
        /*
        provider.request(.testPost).filterSuccessfulStatusCodes().mapJSON().subscribe(onNext:{(json) in
                print(json)
        
        }).addDisposableTo(disposeBag)
        */
        
        /*
        provider.request(.testPost).filterSuccessfulStatusCodes().mapJSON().mapObject(type: Post.self).subscribe(onNext:{(post: Post) in
            
            print(post)
            print(post.title!)
            print(post.body!)
            
        }).addDisposableTo(disposeBag)
        */
        
        // 在viewMoDel中处理网络请求
        viewModel.getPosts().subscribe(onNext: {(posts: [Post]) in
            
            print(posts.count)
        
        }).addDisposableTo(disposeBag)
        
        viewModel.createPost(title: "title", body: "body", userId: 1).subscribe(onNext: {(post: Post) in
            
            print(post.title!)
            
        }).addDisposableTo(disposeBag)
    }
    
}
