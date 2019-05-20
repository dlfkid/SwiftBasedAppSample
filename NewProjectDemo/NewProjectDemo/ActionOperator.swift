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
    func invokeAction(URL: URL, completion: CompletionClousure?) throws -> Any? {
        guard let urlString = URL.query else {
            let error = ActionOperatorError.urlEmpty
            throw error
        }
        var params = [String: Any]()
        for param in urlString.components(separatedBy: "&") {
            let elements = param.components(separatedBy: "=")
            if elements.count < 2 {
                continue
            }
            guard let keyString = elements.first else {
                continue
            }
            params[keyString] = elements.last
        }
        
        let actionName = URL.path.replacingOccurrences(of: "/", with: "")
        if actionName.hasPrefix("native") {
            let error = ActionOperatorError.invokeNativeActionFromRemote
            throw error
        }
        
        let result = try self.invoke(targetName: URL.host ?? "", actionName: actionName, parameters: params, cache: false)
        
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
    func invoke(targetName: String, actionName: String, parameters: [String: Any], cache: Bool) throws ->  Any? {
        let swiftModuleName = parameters[swiftModuleNameKey] as? String
        var targetClassString = ""
        if swiftModuleName?.count ?? 0 > 0 {
            targetClassString = String("\(swiftModuleName).Target_\(targetName)")
        } else {
            targetClassString = String("Target\(targetName)")
        }
        var target: NSObject? = self.cachedTarget[targetClassString] as? NSObject
        
        if target == nil {
            guard let targetClass: NSObject.Type = NSClassFromString(targetClassString) as? NSObject.Type else {
                let error = ActionOperatorError.targetClassNotFound(className: targetClassString)
                throw error
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
            let error = ActionOperatorError.unableToInvokeFunction
            throw error
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

extension ActionOperator {
    enum ActionOperatorError: Error {
        case urlEmpty
        case invokeNativeActionFromRemote
        case targetClassNotFound(className: String)
        case unableToInvokeFunction
        
        
        var info: String {
            switch self {
            case ActionOperatorError.targetClassNotFound(let className):
                return className
                
            default:
                return ""
            }
        }
    }
}
