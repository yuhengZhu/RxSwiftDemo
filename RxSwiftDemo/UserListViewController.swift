//
//  UserListViewController.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/9/1.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableview = UITableView()
    
    let screenH = UIScreen.main.bounds.size.height
    let screenW = UIScreen.main.bounds.size.width
    
    let cellResuedId = "UserListCell"
    
    override func viewDidLoad() {
        
        setUI()
    }
    
    func setUI() {
     
        view.backgroundColor = UIColor.white
        tableview.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH)
        view.addSubview(tableview)
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.register(UserListCell.classForCoder(), forCellReuseIdentifier: cellResuedId)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell: UserListCell = tableView.dequeueReusableCell(withIdentifier: cellResuedId, for: indexPath) as! UserListCell
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88.0
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


