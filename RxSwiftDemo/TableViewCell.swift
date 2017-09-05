//
//  TableViewCell.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/31.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {
    
    var user: User? {
        
        willSet {
            let string = "\(newValue!.screenName)关注了\(newValue!.followingCount)个用户, 并且被\(newValue!.followersCount)个用户关注"
            textLabel?.text = string
            textLabel?.numberOfLines = 0
        }
        
    }
    
}
