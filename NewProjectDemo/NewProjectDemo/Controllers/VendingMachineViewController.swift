//
//  VendingMachineViewController.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/9/16.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import UIKit

class VendingMachineViewController: UIViewController {
    
    // MARK: 幻影类型的核心思想: 通过不存在的类型, 把一些逻辑错误上升为编译错误, 从而帮助开发者在编译期修复逻辑错误

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vending Machine Example"
        view.backgroundColor = .white
        
        let start = Transition<Waiting, CoinInserted>()
        let selectionMade = Transition<CoinInserted, FetchIng>()
        let delievery = Transition<FetchIng, Serving>()
        let rollBack = Transition<Serving, Waiting>()
        
        let m1 = VendingMachine<Waiting>()
        let m2 = m1.transit(with: start)
        let m3 = m2.transit(with: selectionMade)
        let m4 = m3.transit(with: delievery)
        let m5 = m4.transit(with: rollBack)
        
        // let m6 = m5.transit(with: delievery)
        
        let b1 = BloodPack<APositive>(volume: 34)
        
        let b2 = BloodPack<APositive>(volume: 65)
        
        let b3 = BloodPack<BPositive>(volume: 100)
        
        let b4 = b1 + b2
        
        // let b5 = b2 + b3
    }
}
