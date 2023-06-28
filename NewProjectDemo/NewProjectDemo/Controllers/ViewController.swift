//
//  ViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/5/16.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit
import PinLayout
import Foundation

class ViewController: UIViewController {
    
    let demoCellIndentifier = "demoCellIdentifier"
    
    let tableview: UITableView = {
        let result = UITableView(frame: .zero, style: .plain)
        result.separatorStyle = .none
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: demoCellIndentifier)
        view.addSubview(tableview)
    }
    
    @objc func nextButtonDidTappedAction() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
}

// 重载VC生命回调方法
extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View did appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("View will layout subviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("View did layout subviews")
        tableview.pin.all()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View will disappear")
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: demoCellIndentifier, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
