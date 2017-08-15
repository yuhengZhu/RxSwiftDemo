//
//  RegisterViewModel.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/11.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import RxCocoa
import RxSwift

class RegisterViewModel {
    
    // input:初始值为""
    let username = Variable<String>("")
    let password = Variable<String>("")
    let repeatPassword = Variable<String>("")
    let registerTaps = PublishSubject<Void>()
    
    // output
    let usernameUsable: Observable<Result>
    // 密码是否可用
    let passwordUsable: Observable<Result>
    // 密码确定是否正确
    let repeatPasswordUsable: Observable<Result>
    let registerButtonEnabled: Observable<Bool>
    let registerResult: Observable<Result>
    
    
    init() {
        
        let service = ValidationService.instance
        
        usernameUsable = username.asObservable().flatMapLatest { username in
            return service.validateUsername(username: username).observeOn(MainScheduler.instance).catchErrorJustReturn(Result.failed(message: "username检测出错"))
        }.shareReplay(1)
        
        
        passwordUsable = password.asObservable().map { password in
            return service.validdatePassword(password)
        }.shareReplay(1)
        
        repeatPasswordUsable = Observable.combineLatest(password.asObservable(), repeatPassword.asObservable()) {
            return service.validateRepeatedPassword($0, repeatedPassword: $1)
        }.shareReplay(1)
        
        registerButtonEnabled = Observable.combineLatest(usernameUsable, passwordUsable, repeatPasswordUsable) {
            (username, password, repeatPassword) in
            username.isValid && password.isValid && repeatPassword.isValid
        }.distinctUntilChanged().shareReplay(1)
        
        let usernameAndPassword = Observable.combineLatest(username.asObservable(), password.asObservable()) {
            ($0, $1)
        }
        
        registerResult = registerTaps.asObservable().withLatestFrom(usernameAndPassword).flatMapLatest { (username, password) in
            return service.register(username, password: password).observeOn(MainScheduler.instance).catchErrorJustReturn(Result.failed(message: "注册出错"))
        }.shareReplay(1)
    }
}
