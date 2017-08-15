//
//  Protocol.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/11.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// 关联枚举(关联值)
enum Result {
    case ok(message: String)
    case empty
    case failed(message: String)
}

extension Result {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false;
        }
    }
}

extension Result {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}

extension Result {
    
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let.failed(message):
            return message
        }
    }
}

extension Reactive where Base: UILabel {
    var validationResult: UIBindingObserver<Base, Result> {
        return UIBindingObserver(UIElement: base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base: UITextField {
//    var inputEnabled: UIBindingObserver<Base, Result> {
//        return UIBindingObserver(UIElement: base) { textField, result in
//            textField.isEnabled = result.isValid
//        }
//    }
}

extension Reactive where Base: UIBarButtonItem {
//    var tapEnabled: UIBindingObserver<Base, Result> {
//        return UIBindingObserver(UIElement: base) { button, result in
//            button.isEnabled = result.isValid;
//        }
//    }
}
