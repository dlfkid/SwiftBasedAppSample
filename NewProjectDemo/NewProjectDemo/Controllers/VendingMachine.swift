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

struct VendingMachine<State> {
    func transit<To>(with transition: Transition<State, To>) -> VendingMachine<To> {
        .init()
    }
}
