//
//  Post.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/18.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable {
    
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        userId <- map["userId"]
    }
}
