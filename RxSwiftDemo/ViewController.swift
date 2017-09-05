//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/11.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = RegisterViewModel()
        
        // orEmpty 把String?过滤nil帮我们变为String类型
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.username).addDisposableTo(disposeBag)
        
        viewModel.usernameUsable.bind(to: usernameLabel.rx.validationResult).addDisposableTo(disposeBag)
        
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).addDisposableTo(disposeBag)
        
        repeatPasswordTextField.rx.text.orEmpty.bind(to: viewModel.repeatPassword).addDisposableTo(disposeBag)
        
        viewModel.passwordUsable.bind(to: passwordLabel.rx.validationResult).addDisposableTo(disposeBag)
        
//        viewModel.passwordUsable.bind(to: repeatPasswordTextField.rx.inputEnabled).addDisposableTo(disposeBag)
        
        viewModel.repeatPasswordUsable.bind(to: repeatPasswordLabel.rx.validationResult).addDisposableTo(disposeBag)
        
        registerButton.rx.tap.bind(to: viewModel.registerTaps).addDisposableTo(disposeBag)
        
        viewModel.registerButtonEnabled.subscribe(onNext: { [unowned self] valid in
            
            self.registerButton.isEnabled = valid
            self.registerButton.alpha = valid ? 1.0 : 0.5;
            
        }).addDisposableTo(disposeBag)
        
        
        viewModel.registerResult.subscribe (onNext: { [unowned self] result in
            switch result {
                case let .ok(message):
                    self.showAlert(message: message)
                case .empty:
                    self.showAlert(message: " ")
                case let .failed(message):
                    self.showAlert(message: message)
            }
        }).addDisposableTo(disposeBag)
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
        
        
        /*
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        */
        
        /*
        let userListViewController = UserListViewController()
        navigationController?.pushViewController(userListViewController, animated: true)
        */
    }

    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

