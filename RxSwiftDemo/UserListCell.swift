//
//  UserListCell.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/9/1.
//  Copyright © 2017年 yuheng. All rights reserved.
//


import UIKit
import Kingfisher   
import SnapKit

class UserListCell: UITableViewCell {
    
    var userNameLabel: UILabel?
    
    var userAvatImageView: UIImageView?
    
    var arrowImageView: UIImageView?
    
    let screenH = UIScreen.main.bounds.size.height
    let screenW = UIScreen.main.bounds.size.width
    
    let cellIdentifierId = "UserListCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.frame.size.height = 88.0
        self.frame.size.width = screenW
        self.contentView.frame.size.height = 88.0
        self.contentView.frame.size.width = screenW
        
        
        // 用户头像
        let userAvatImageViewW: CGFloat = 60
        let userAvatImageViewX: CGFloat = 20
        let userAvatImageViewH: CGFloat = userAvatImageViewW
        let userAvatImageViewY: CGFloat = (self.frame.size.height - userAvatImageViewH) / 2.0
        
        userAvatImageView = UIImageView()
        contentView.addSubview(userAvatImageView!)
        /*
        userAvatImageView?.snp.makeConstraints({ (make) in
            make.height.equalTo(75)
            make.width.equalTo(60)
            make.left.equalTo(20)
            make.centerY.equalTo(20)
        })
        */
        userAvatImageView?.frame = CGRect(x: userAvatImageViewX, y: userAvatImageViewY, width: userAvatImageViewW, height: userAvatImageViewH)
    
        // 头像图片
        let avatImage = UIImage(named: "Avatar")
        
        let userAvatImageViewBounds = userAvatImageView!.bounds
        
        // 测试网络头像
        let url = URL(string: "https://oss.aliyuncs.com/tcxy/test/user/df8b97d899b546fcb5e8b14f364e6251.jpg")
//        let url = URL(string: "https://oss.aliyuncs.com/tcxy/test/user/df8b97d899b546fcb5e8b14f364e6252.jpg")
        
        userAvatImageView!.kf.setImage(with: url, placeholder: avatImage, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            
//            let layer = CAShapeLayer()
//            layer.frame = userAvatImageViewBounds
            if (image != nil) {
                
                UIGraphicsBeginImageContextWithOptions(userAvatImageViewBounds.size, false, 0.0)
                let bezierPath = UIBezierPath(roundedRect: userAvatImageViewBounds, cornerRadius: userAvatImageViewW / 2.0)
                bezierPath.addClip()
                //            layer.path = bezierPath.cgPath
                image?.draw(in: userAvatImageViewBounds)
                
                self.userAvatImageView?.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

            }
//            self.layer.addSublayer(layer)
        })
        
        // 用户名称
        let userNameLabelX: CGFloat = userAvatImageView!.frame.size.width + userAvatImageView!.frame.origin.x + 20
        let userNameLabelH: CGFloat = 21
        let userNameLabelW: CGFloat = 200
        let userNameLabelY: CGFloat = (self.frame.size.height - userNameLabelH) / 2.0;
        userNameLabel = UILabel()
        userNameLabel?.frame = CGRect(x: userNameLabelX, y: userNameLabelY, width: userNameLabelW, height: userNameLabelH)
        userNameLabel?.text = "用户姓名"
        
        let arrowImageViewW: CGFloat = 38;
        let arrowImageViewH: CGFloat = arrowImageViewW;
        let arrowImageViewX: CGFloat = contentView.frame.size.width - arrowImageViewW - 10;
        let arrowImageViewY: CGFloat = (self.frame.size.height - arrowImageViewH) / 2.0;
        arrowImageView = UIImageView()
        arrowImageView?.frame = CGRect(x: arrowImageViewX, y: arrowImageViewY, width: arrowImageViewW, height: arrowImageViewH)
        arrowImageView?.image = UIImage(named:"rightArrow")
        
        
        // 加入
        contentView.addSubview(userNameLabel!)
        
        contentView.addSubview(arrowImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
