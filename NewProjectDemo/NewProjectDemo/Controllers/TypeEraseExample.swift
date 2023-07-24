//
//  TypeEraseExample.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2023/7/24.
//  Copyright © 2023 LeonDeng. All rights reserved.
//

import Foundation

protocol MetricAggregation {
    associatedtype DataPointValue
    func aggregate(_ dataPoint: DataPointValue) -> DataPointValue
}

struct SumDataPoint: MetricAggregation {
    func aggregate(_ dataPoint: Int) -> Int {
        let newValue = (value + dataPoint)
        print("sum => param: \(dataPoint), val: \(value), result: \(newValue)")
        return newValue
    }

    let value: Int
}

struct AverageDataPoint: MetricAggregation {
    
    func aggregate(_ dataPoint: Int) -> Int {
        let newValue = (value + dataPoint) / 2
        print("avg => param: \(dataPoint), val: \(value), result: \(newValue)")
        return newValue
    }
    
    let value: Int
}

struct AggregateUnit<DataPointValue>: MetricAggregation {
    
    // 用成员变量闭包保存结构体实例的方法
    private let _aggregate: (_ dataPoint: DataPointValue) -> DataPointValue
    
    init<T: MetricAggregation>(_ unit: T) where T.DataPointValue == DataPointValue {
        _aggregate = unit.aggregate(_:)
    }
    
    func aggregate(_ dataPoint: DataPointValue) -> DataPointValue {
        return _aggregate(dataPoint)
    }
}
