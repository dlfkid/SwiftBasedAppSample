//
//  ViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/5/16.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

struct DemoOption {
    let title: String
    let selectHandler: (_ option: DemoOption) -> Void
}

class ViewController: UIViewController {
    
    let demoCellIndentifier = "demoCellIdentifier"
    
    var dataSource = [DemoOption]()
    
    let tableview: UITableView = {
        let result = UITableView(frame: .zero, style: .plain)
        result.separatorStyle = .none
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        tableview.separatorStyle = .none
        navigationItem.title = "demo_pages"
        dataSource = [
            DemoOption(title: "LoginViewController", selectHandler: { [unowned self] option in
                print("Calling \(option.title) closure")
            let controller = LoginViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }),
            DemoOption(title: "VendingMachine", selectHandler: { [unowned self] option in
                print("Calling \(option.title) closure")
                let controller = VendingMachineViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            })
        ]
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: demoCellIndentifier)
        view.addSubview(tableview)
    }
}

// 重载VC生命回调方法
extension ViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sum1 = AggregateUnit(SumDataPoint(value: 6))
        let sum2 = AggregateUnit(SumDataPoint(value: 3))
        let sum3 = AggregateUnit(SumDataPoint(value: 9))
        let sum4 = AggregateUnit(SumDataPoint(value: 4))
        let avg1 = AggregateUnit(AverageDataPoint(value: 8))
        let avg2 = AggregateUnit(AverageDataPoint(value: 1))
        let avg3 = AggregateUnit(AverageDataPoint(value: 2))
        let avg4 = AggregateUnit(AverageDataPoint(value: 4))
        let avg5 = AggregateUnit(AverageDataPoint(value: 5))
        let array = [sum1, sum2, sum3, sum4, avg1, avg2, avg3, avg4, avg5]
        let output = array.reduce(0) { (result, unit) -> Int in
            return unit.aggregate(result)
        }
        print("View will appear \(output)")
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
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: demoCellIndentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = option.title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = dataSource[indexPath.row]
        option.selectHandler(option)
    }
}
