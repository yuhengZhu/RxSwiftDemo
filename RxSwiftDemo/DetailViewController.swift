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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let provider = MoyaProvider<AccountService>()
        /*
        provider.request(AccountService.testGet) { result in
            
            switch result {
                
            case let .success(response):
                print(response)
            
            default:
                print(result)
            }
        }
        */
        provider.request(AccountService.testPost) { result in
            print(result)
            switch result {
                
            case let .success(response):
                print(response)
                
            default:
                print(result)
            }
        }
        
//        provider.request(AccountService.testPost).mapJSON().mapObject(type: Post.self)
        
    }
    
}
