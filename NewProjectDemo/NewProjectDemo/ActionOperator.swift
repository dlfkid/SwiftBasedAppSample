//
//  ActionOperator.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/5/16.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit

typealias CompletionClousure = ([String: Any?]) -> Void

let swiftModuleNameKey = "ParamsKeySwiftTargetModuleName"

class ActionOperator: NSObject {
    lazy var cachedTarget: [String: Any] = {
            return [:]
        }()
    
    static let sharedOperator = ActionOperator()
    
    /// 通过URL远程调用方法
    ///
    /// - Parameters:
    ///   - URL: 方法URL
    ///   - completion: 回调闭包
    /// - Returns: 返回值
    func invokeAction(URL: URL, completion: CompletionClousure?) -> Any? {
        guard let urlString = URL.query else {
            return nil
        }
        var params = [String: Any]()
        for param in urlString.components(separatedBy: "&") {
            let elts = param.components(separatedBy: "=")
            if elts.count < 2 {
                continue
            }
            guard let keyString = elts.first else {
                continue
            }
            params[keyString] = elts.last
        }
        
        let actionName = URL.path.replacingOccurrences(of: "\\", with: "")
        if actionName.hasPrefix("native") {
            return false
        }
        
        let result = self.invoke(targetName: URL.host ?? "", actionName: actionName, parameters: params, cache: false)
        guard let handler = completion else {
            return result
        }
        handler(["result": result])
        return result
    }
    
    /// 调用指定对象方法
    ///
    /// - Parameters:
    ///   - targetName: 类名
    ///   - actionName: 方法名
    ///   - parameters: 参数
    ///   - cache: 是否需要缓存对象
    /// - Returns: 返回值
    func invoke(targetName: String, actionName: String, parameters: [String: Any], cache: Bool) -> Any? {
        let swiftModuleName = parameters[swiftModuleNameKey] as? String
        var targetClassString = ""
        if swiftModuleName?.count ?? 0 > 0 {
            targetClassString = String("\(swiftModuleName).Target_\(targetName)")
        } else {
            targetClassString = String("Target_\(targetName)")
        }
        var target: NSObject? = self.cachedTarget[targetClassString] as? NSObject
        
        if target == nil {
            guard let targetClass: NSObject.Type = NSClassFromString(targetClassString) as? NSObject.Type else {
                return nil
            }
            target = targetClass.init()
        }
        
        let actionString = "Action_\(actionName)"
        let action = NSSelectorFromString(actionString)
        
        if cache {
            self.cachedTarget[targetClassString] = target
        }
        
        if target?.responds(to: action) ?? false {
            return target?.perform(action)
        } else {
            self.cachedTarget.removeValue(forKey: targetClassString)
            return nil
        }
    }
    
    /// 释放已缓存的对象
    ///
    /// - Parameter targetName: 对象名
    func realeaseCachedTarget(targetName: String) {
        let targetClassString = "Target_\(targetName)"
        self.cachedTarget.removeValue(forKey: targetClassString)
    }
}
