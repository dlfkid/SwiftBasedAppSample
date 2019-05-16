//
//  ActionOperator.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/5/16.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit

typealias CompletionClousure = ([NSObject: NSObject]) -> Void

class ActionOperator: NSObject {
    static let sharedOperator = ActionOperator()
    
    /// 通过URL远程调用方法
    ///
    /// - Parameters:
    ///   - URL: 方法URL
    ///   - completion: 回调闭包
    /// - Returns: 返回值
    func invokeAction(URL: URL, completion: CompletionClousure) -> NSObject {
        return NSObject()
    }
    
    /// 调用指定对象方法
    ///
    /// - Parameters:
    ///   - targetName: 类名
    ///   - actionName: 方法名
    ///   - parameters: 参数
    ///   - cache: 是否需要缓存对象
    /// - Returns: 返回值
    func invoke(targetName: String, actionName: String, parameters: [NSObject: NSObject], cache: Bool) -> NSObject {
        return NSObject()
    }
    
    /// 释放已缓存的对象
    ///
    /// - Parameter targetName: 对象名
    func realeaseCachedTarget(targetName: String) {
        
    }
    
}
