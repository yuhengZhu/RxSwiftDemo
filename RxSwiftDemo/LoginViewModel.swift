//
//  LoginViewModel.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/16.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    
    // output:
    let usernameUsable: Driver<Result>
    let loginButtonEnabled: Driver<Bool>
    let loginResult: Driver<Result>
    
    init(input: (username: Driver<String>, password: Driver<String>, loginTaps: Driver<Void>), service: ValidationService) {
        
        usernameUsable = input.username.flatMapLatest { username in
            return service.loginUsernameValid(username).asDriver(onErrorJustReturn: .failed(message: "连接server失败"))
        }
        
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            ($0, $1)
        }
        
        loginResult = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest { (username, password) in
            return service.login(username, password: password).asDriver(onErrorJustReturn: .failed(message: "连接server失败"))
        }
        
        loginButtonEnabled = input.password.map {
            $0.characters.count > 0
        }.asDriver()
    }
}
