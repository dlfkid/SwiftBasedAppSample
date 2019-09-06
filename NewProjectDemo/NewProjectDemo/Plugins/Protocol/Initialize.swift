//
//  Initialize.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/6.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import Foundation
import UIKit.UIApplication

/// 用于实现类似OC的load / initialize 效果，遵守此协议的类会在被加载的时候调用awake方法供开发者执行类的初始化操作
protocol Initialize: NSObjectProtocol {
    static func awake()
}

extension NSObject {
    static func initializeAllClass() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? Initialize.Type)?.awake()
        }
        types.deallocate()
    }
}

extension UIApplication {
    private static let runOnce: Void = {
        NSObject.initializeAllClass()
    }()
    
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}
