//
//  VendingMachine.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/6/18.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import Foundation

enum VendingMachineError: Error {
    case invalidSelection(selection: VendingSelection)
    case insufficientFunds(lackOfFund: Int)
    case outOfStock
}

struct VendingItem {
    let price: Int
    var quantity: Int
    let name: String
    let selection: VendingSelection
}

enum VendingSelection: String {
    case soda
    case dietSoda
    case chips
    case cookie
    case sandwich
    case wrap
    case candyBar
    case popTart
    case water
    case fruitJuice
    case sportsDrink
    case gum
}

final class VendingMachine {
        
        var inventory = [VendingSelection: VendingItem]()
        var amountDeposited = 0
        
        init(inventory: [VendingSelection: VendingItem]) {
            self.inventory = inventory
        }
    
    convenience init() {
        let defaultInventory: [VendingSelection: VendingItem] = [
            .soda: VendingItem(price: 4, quantity: 18, name: "CocaCola", selection: .soda),
            .chips: VendingItem(price: 7, quantity: 4, name: "HotWave", selection: .chips),
            .gum: VendingItem(price: 2, quantity: 34, name: "GreenArrow", selection: .gum),
            .water: VendingItem(price: 15, quantity: 20, name: "Perrier", selection: .water)
        ]
        self.init(inventory: defaultInventory)
    }
        
        func vend(_ selection: VendingSelection, quantity: Int) throws -> [VendingItem] {
            guard var item = inventory[selection] else {
                throw VendingMachineError.invalidSelection(selection: selection)
            }
            
            guard item.quantity >= quantity else {
                throw VendingMachineError.outOfStock
            }
            
            guard amountDeposited >= item.price * quantity else {
                throw VendingMachineError.insufficientFunds(lackOfFund: item.price - amountDeposited)
            }
            
            amountDeposited -= item.price * quantity
            item.quantity -= quantity
            inventory.updateValue(item, forKey: selection)
            
            var items = [VendingItem]()
            for _ in 0..<quantity {
                items.append(item)
            }
            
            return items
        }
        
        func deposit(_ amount: Int) {
            amountDeposited += amount
        }
        
        func item(forSelection selection: VendingSelection) -> VendingItem? {
            return inventory[selection]
        }
    
}
