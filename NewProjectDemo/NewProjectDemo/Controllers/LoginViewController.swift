//
//  LoginViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/6/28.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let submitButton = UIButton(type: .custom)
    let accountTextField = UITextField(frame: .zero)
    let passwordTextField = UITextField(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }

}
