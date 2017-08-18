//
//  Service.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/11.
//  Copyright © 2017年 yuheng. All rights reserved.
//  负责一些网络请求，和一些数据库的访问操作。供ViewModel去使用

import Foundation
import RxCocoa
import RxSwift


class ValidationService {
    
    static let instance = ValidationService()
    
    private init() {
        
    }
    
    let minCharactersCount = 6
    
    func validateUsername(username: String) -> Observable<Result> {
        
        // 当字符等于0的时候什么都不做
        if username.characters.count == 0 {
            return Observable.just(Result.empty)
        }
        
        if username.characters.count < minCharactersCount {
            return Observable.just(Result.failed(message: "号码长度至少6位"))
        }
        
        // 检测本地数据库中用户名称是否已经存在
        if usernameVaild(username) {
            return Observable.just(Result.failed(message: "用户名已存在"))
        }
        
        return Observable.just(Result.ok(message: "用户名可用"))
    }
    
    func register(_ username: String, password: String) -> Observable<Result> {
        
        let userDict = [username: password];
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        
        if (userDict as NSDictionary).write(toFile: filePath, atomically: true) {
            return Observable.just(Result.ok(message: "注册成功"))
        }
        
        return Observable.just(Result.failed(message: "注册失败"))
    }
    
    // 本地数据库中检测用户名称是否存在
    func usernameVaild(_ username: String) -> Bool {
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        
        if (userDic == nil) {
            let tempDict = Dictionary<String, Any>()
            NSDictionary(dictionary: tempDict).write(toFile: filePath, atomically: true)
            return true
        }
        
        let usernameArray = userDic!.allKeys as NSArray
        if usernameArray.contains(username) {
            return true
        } else {
            return false
        }
    }
 
    
    func validdatePassword(_ password: String) -> Result {
        
        if password.characters.count == 0 {
            return .empty
        }
        
        if password.characters.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        
        return .ok(message: "密码可用")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> Result {
        if repeatedPassword.characters.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "密码可用")
        }
        
        return .failed(message: "两次密码不一样")
    }
    
    func loginUsernameValid(_ username: String) -> Observable<Result> {
        
        if username.characters.count == 0 {
            
            return Observable.just(Result.empty)
        }
        
        if usernameVaild(username) {
            return Observable.just(Result.ok(message: "用户名可用"))
        }
        
        return Observable.just(Result.failed(message: "用户名不存在"))
    }
    
    func login(_ username: String, password: String) -> Observable<Result> {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        if let userPass = userDic?.object(forKey: username) as? String {
            
            if userPass == password {
                return Observable.just(Result.ok(message: "登录成功"))
            }
        }
        return Observable.just(Result.failed(message: "密码错误"))
    }
}

class SearchService {
    
    static let shareInstance = SearchService()

    private init() {}
    
    func getThings(withName name: String) -> Observable<[Thing]> {
        let thingsString = Bundle.main.path(forResource: "things", ofType: "plist")
        let thingsArray = NSArray(contentsOfFile: thingsString!) as! Array<[String: String]>
        var things = [Thing]()
        for thingDict in thingsArray {
            if thingDict["name"]!.contains(name) {
                let thing = Thing(name: thingDict["name"]!, desc: thingDict["intro"]!, icon: thingDict["icon"]!)
                things.append(thing)
            }
        }
        return Observable.just(things).observeOn(MainScheduler.instance)
    }
}

