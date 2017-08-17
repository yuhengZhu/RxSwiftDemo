//
//  LoginViewController.swift
//  RxSwiftDemo
//
//  Created by yuheng on 2017/8/16.
//  Copyright © 2017年 yuheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class LoginViewController: UIViewController {
    
    let usernameTextField: UITextField = UITextField()
    
    let usernameLabel: UILabel = UILabel()
    
    let passwordTextField: UITextField = UITextField()
    
    let passwordLabel: UILabel = UILabel()
    
    let loginButton: UIButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        let viewModel = LoginViewModel(input: (username: usernameTextField.rx.text.orEmpty.asDriver(), password: passwordTextField.rx.text.orEmpty.asDriver(), loginTaps: loginButton.rx.tap.asDriver()), service: ValidationService.instance)
        
        viewModel.usernameUsable.drive(usernameLabel.rx.validationResult).addDisposableTo(disposeBag)
        
        viewModel.loginButtonEnabled.drive(onNext: { [unowned self] valid in
            
            self.loginButton.isEnabled = valid
            self.loginButton.alpha = valid ? 1 : 0.5
            
        }).addDisposableTo(disposeBag)
        
        viewModel.loginResult.drive(onNext: { [unowned self] result in
            switch result {
            case let .ok(message):
                let viewController = ContainerViewController()
                self.navigationController?.pushViewController(viewController, animated: true)
                self.showAlert(message: message)
            case .empty:
                self.showAlert(message: "")
            case let .failed(message):
                self.showAlert(message: message)
            }
        }).addDisposableTo(disposeBag)
    }
    
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        let marginLeft: CGFloat = 10.0
        let promptW: CGFloat = 80
        
        let usernamePromptLabel = UILabel(frame: CGRect(x: marginLeft, y: 100, width: promptW, height: 21))
        usernamePromptLabel.text = "用户名"
        usernamePromptLabel.textColor = UIColor.black
        view.addSubview(usernamePromptLabel)
        
        let usernameTextFieldX = usernamePromptLabel.frame.size.width + usernamePromptLabel.frame.origin.x + 10
        let usernameTextFieldY = usernamePromptLabel.frame.origin.y
        usernameTextField.frame = CGRect(x: usernameTextFieldX, y: usernameTextFieldY, width: 200, height: 21)
        usernameTextField.borderStyle = .roundedRect
        view.addSubview(usernameTextField)
        
        // 用户名:
        let usernameLabelY = usernamePromptLabel.frame.size.height + usernamePromptLabel.frame.origin.y + 5
        let usernameLabelW: CGFloat = 200;
        let usernameLabelX = (view.frame.size.width - usernameLabelW) / 2.0;
        usernameLabel.frame = CGRect(x: usernameLabelX, y: usernameLabelY, width: usernameLabelW, height: 21)
        view.addSubview(usernameLabel)
        
        // 密码:
        let passwordPromptLabelY: CGFloat = usernameLabel.frame.size.height + usernameLabel.frame.origin.y + 10;
        let passwordPromptLabel = UILabel(frame: CGRect(x: marginLeft, y: passwordPromptLabelY, width: promptW, height: 21))
        passwordPromptLabel.text = "密码"
        passwordPromptLabel.textColor = UIColor.black
        view.addSubview(passwordPromptLabel)
        
        let passwordTextFieldX = passwordPromptLabel.frame.size.width + passwordPromptLabel.frame.origin.x + 10
        let passwordTextFieldY = passwordPromptLabel.frame.origin.y
        passwordTextField.frame = CGRect(x: passwordTextFieldX, y: passwordTextFieldY, width: 200, height: 21)
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        let passwordLabelY = (passwordPromptLabel.frame.size.height + passwordPromptLabel.frame.origin.y + 10.0);
        passwordLabel.frame = CGRect(x: marginLeft, y: passwordLabelY, width: 200.0, height: 21.0)
        view.addSubview(passwordLabel)
    
        
        let loginButtonW: CGFloat = 200.0
        let loginButtonX: CGFloat = (view.frame.size.width - loginButtonW) / 2;
        let loginButtonY: CGFloat = 200.0
        let loginButtonH: CGFloat = 40.0
        loginButton.frame = CGRect(x: loginButtonX, y: loginButtonY, width: loginButtonW, height: loginButtonH)
        view.addSubview(loginButton)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        let touchSelector = NSSelectorFromString("loginAction")
        loginButton.addTarget(self, action: touchSelector, for: .touchUpInside)
    
        
        let avatarImageViewW: CGFloat = 50
        let avatarImageViewH: CGFloat = 50
        let avatarImageViewX = (view.frame.size.width - avatarImageViewW) / 2.0
        let avatarImageViewY: CGFloat = 300
        let avatarImageView = UIImageView()
        avatarImageView.frame = CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewW, height: avatarImageViewH)
        view.addSubview(avatarImageView)
        avatarImageView.image = UIImage(named: "backGround")
    }
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
    
    func loginAction() {
        print("loginAction")
    }

}
