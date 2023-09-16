//
//  BloodTypes.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/9/16.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import Foundation

enum APositive {}

enum BPositive {}

enum OPositive {}

struct BloodPack <BloodType> {
    let volume: Int
    static func +(lhs: BloodPack, rhs: BloodPack) -> BloodPack {
        return BloodPack(volume: lhs.volume + rhs.volume)
    }
}
