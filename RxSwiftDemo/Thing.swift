//
//  Thing.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/17.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation

class Thing: NSObject {
    
    var name: String
    var desc: String
    var icon: String
    
    init(name: String, desc: String, icon: String) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
}
