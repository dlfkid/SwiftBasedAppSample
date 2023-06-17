//
//  ViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/5/16.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonDidTappedAction))
        let vendingMachine = VendingMachine()
        vendingMachine.deposit(10)
        do {
            let vendedItem = try vendingMachine.vend(.water, quantity: 1)
            print("I just brought \(vendedItem.first?.name ?? "")")
        } catch VendingMachineError.insufficientFunds(let lack) {
            print("Need to deposit \(lack) more bucks")
        } catch VendingMachineError.invalidSelection(let selection) {
            print("This vending machine doesn't sell \(selection)")
        } catch VendingMachineError.outOfStock {
            print("This vending machine is out of \(VendingSelection.water)")
        } catch {
            print("Unexpected error.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
    }
    
    @objc func nextButtonDidTappedAction() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
}
