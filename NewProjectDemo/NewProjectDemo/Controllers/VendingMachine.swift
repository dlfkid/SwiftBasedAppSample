//
//  VendingMachine.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/6/18.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import Foundation

enum Waiting {}

enum CoinInserted {}

enum FetchIng {}

enum Serving {}

struct Transition <From, To> {
    
}

protocol VendingOrderable {
    var orderId: Int {get}
    var price: Int {get}
    var name: String {get}
}

struct VendingOrder<State>: VendingOrderable {
    let orderId: Int
    let price: Int
    let name: String
    
    /// 转换订单的状态
    /// - Parameter transition: 订单转换状态
    /// - Returns: 转换状态后的订单
    func transit<ToState>(_ transition: Transition<State, ToState>) -> VendingOrder<ToState> {
        return VendingOrder<ToState>(orderId: orderId, price: price, name: name)
    }
}

struct VendingOrderWrapper: VendingOrderable {
    
    let orderId: Int
    let price: Int
    let name: String
    
    init<OrderType: VendingOrderable>(order: OrderType) {
        self.orderId = order.orderId
        self.price = order.price
        self.name = order.name
    }
}

class VendingMachine {
    
    private var orderIndex = 0
    
    private var orders: [VendingOrderWrapper] = [VendingOrderWrapper]()
    
    func generateNewOrder(name: String, price: Int) -> VendingOrder<Waiting> {
        let order = VendingOrder<Waiting>(orderId: orderIndex, price: price, name: name)
        let wrapper = VendingOrderWrapper(order: order)
        orders.append(wrapper)
        orderIndex += 1
        return order
    }
}
