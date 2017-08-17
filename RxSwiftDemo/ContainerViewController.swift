//
//  ContainerViewController.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/17.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContainerViewController: UIViewController {
    
    let cellResuedId: String = "tableViewCell"
    
    let tableView: UITableView! = UITableView()
    
    let searchBar: UISearchBar = UISearchBar()
    
    let disposeBag = DisposeBag()
    
    var searchBarText: Observable<String> {
        
        return searchBar.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let viewModel = ContainerViewModel(withSearchText: searchBarText, service: SearchService.shareInstance)
        
        viewModel.models.drive(tableView.rx.items(cellIdentifier: cellResuedId, cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.desc
            cell.imageView?.image = UIImage(named: element.icon)
        }.addDisposableTo(disposeBag)
 
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.gray
        
        let searchBarX: CGFloat = 0;
        let searchBarY: CGFloat = 64;
        let searchBarW: CGFloat = view.frame.size.width;
        let searchBarH: CGFloat = 40;
        searchBar.frame = CGRect(x: searchBarX, y: searchBarY, width: searchBarW, height: searchBarH)
        view.addSubview(searchBar)
        
        let tableViewX: CGFloat = 0
        let tableViewY: CGFloat = searchBar.frame.size.height + searchBar.frame.origin.y
        let tableViewW: CGFloat = view.frame.size.width
        let tableViewH: CGFloat = view.frame.size.height - searchBarH - 64
        tableView.frame = CGRect(x: tableViewX, y: tableViewY, width: tableViewW, height: tableViewH)
        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self;
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellResuedId)
        
    }
    /*
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellResuedId, for: indexPath) as UITableViewCell?
        if (tableViewCell == nil) {
            tableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: cellResuedId)
        }
        return tableViewCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 */
}
