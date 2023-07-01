//
//  LoginViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/6/28.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let submitButton = UIButton(type: .custom)
    let accountTextField = UITextField(frame: .zero)
    let passwordTextField = UITextField(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupContent()
    }

    func setupContent() {
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        submitButton.layer.cornerRadius = 4
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .lightGray
        view.addSubview(submitButton)
        
        accountTextField.placeholder = "Please input your account"
        accountTextField.borderStyle = .roundedRect
        accountTextField.layer.borderWidth = 0.5
        accountTextField.layer.cornerRadius = 4
        view.addSubview(accountTextField)
        
        passwordTextField.placeholder = "Please input your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.passwordRules = UITextInputPasswordRules(descriptor: "minlength: 8; required: lower; required: upper; required: digit;")
        view.addSubview(passwordTextField)
        
        submitButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(-(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)).offset(-60)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.snp.centerY)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(50)
        }
        
        accountTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.passwordTextField.snp.top).offset(-16)
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension LoginViewController {
    @objc func submitButtonTapped(_ sender: UIButton) {
        print("Submit button tapped")
        guard accountTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0 else {
            return
        }
        let signInAccount = Account(account: accountTextField.text!, password: passwordTextField.text!)
        accountTextField.text = nil
        passwordTextField.text = nil
        let nextVC = NextViewController(account: signInAccount)
        nextVC.onSignoutCallback = { signoutAccount in
            print("Signout account: \(signoutAccount.account)")
            self.accountTextField.text = signoutAccount.account
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
