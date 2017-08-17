//
//  ContainerViewModel.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/17.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ContainerViewModel {
    
    // output:
    var models: Driver<[Thing]>
    
    init(withSearchText searchText: Observable<String>, service: SearchService) {
        models = searchText.debug().observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).flatMap { text in
                return service.getThings(withName: text)
            }.asDriver(onErrorJustReturn: [])
    }
}
