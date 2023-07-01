//
//  NextViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/6.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    typealias SignoutHandler = (_ signoutAccount: Account) -> Void
    
    var onSignoutCallback: SignoutHandler?
    
    let account: Account
    
    let logoutButton = UIButton(type: .custom)
    
    /// account lable shows in the top left corner of the view
    let accountLabel = UILabel(frame: .zero)
    
    let welcomeLabel = UILabel(frame: .zero)
    
    init(account: Account) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContent()
    }
    
    func setupContent() {
        navigationItem.title = "Next View Controller"
        view.backgroundColor = .white
        accountLabel.text = account.account
        accountLabel.textColor = .black
        accountLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(accountLabel)
        
        accountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.view.snp.centerY)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        welcomeLabel.text = "You are using the app, welcome!"
        welcomeLabel.textColor = .black
        welcomeLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(16)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .red
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(-(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)).offset(-60)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(55)
        }
    }
}

extension NextViewController {
    @objc func logoutButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        guard let handler = self.onSignoutCallback else {
            return
        }
        handler(account)
    }
}
