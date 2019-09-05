//
//  NSObjectRuntime.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// 返回本对象所属类的所有方法
    var methodNames: [String] {
//        unsigned int count;
//        Method *methodList = class_copyMethodList(self, &count);
//        NSMutableArray *methodNames = [NSMutableArray array];
//        for (int i = 0; i < count; i++) {
//            Method method = methodList[i];
//            NSString *methodName = [NSString stringWithFormat:@"%s%s", __func__, sel_getName(method_getName(method))];
//            [methodNames addObject:methodName];
//        }
//        return methodNames;
        var count: UInt32 = 0
        guard let methodList: UnsafeMutablePointer<Method> = class_copyMethodList(self.classForCoder, &count) else {
            return [""]
        }
        var methodNames = [String]()
        for index in 0...Int(count) {
            let method = methodList[index]
            let methodName = String(format: "%s%s", #function, sel_getName(method_getName(method)))
            methodNames.append(methodName)
        }
        return methodNames
    }
    
    /// 执行方法替换
    ///
    /// - Parameters:
    ///   - selector1: 原方法
    ///   - selector2: 新方法
    func swizzleInstanceMethod(selector1: Selector, selector2: Selector) {
        guard let methodOrigin = class_getInstanceMethod(self.classForCoder, selector1) else {
            return
        }
        guard let methodNew = class_getInstanceMethod(self.classForCoder, selector2) else {
            return
        }
        let addSuccess: Bool = class_addMethod(self.classForCoder, selector1, method_getImplementation(methodNew), method_getTypeEncoding(methodNew))
        if addSuccess {
            class_replaceMethod(self.classForCoder, selector2, method_getImplementation(methodOrigin), method_getTypeEncoding(methodOrigin))
        } else {
            method_exchangeImplementations(methodOrigin, methodNew)
        }
    }
    
    /// 执行方法替换
    ///
    /// - Parameters:
    ///   - selector1: 原方法
    ///   - selector2: 新方法
    static func swizzleInstanceMethod(selector1: Selector, selector2: Selector) {
        guard let methodOrigin = class_getInstanceMethod(self, selector1) else {
            return
        }
        guard let methodNew = class_getInstanceMethod(self, selector2) else {
            return
        }
        let addSuccess: Bool = class_addMethod(self, selector1, method_getImplementation(methodNew), method_getTypeEncoding(methodNew))
        if addSuccess {
            class_replaceMethod(self, selector2, method_getImplementation(methodOrigin), method_getTypeEncoding(methodOrigin))
        } else {
            method_exchangeImplementations(methodOrigin, methodNew)
        }
    }
    
    /// 执行方法替换
    ///
    /// - Parameters:
    ///   - selector1: 原方法
    ///   - selector2: 新方法
    static func swizzleClassMethod(selector1: Selector, selector2: Selector) {
        guard let methodOrigin = class_getClassMethod(self, selector1) else {
            return
        }
        guard let methodNew = class_getClassMethod(self, selector2) else {
            return
        }
        let addSuccess: Bool = class_addMethod(self, selector1, method_getImplementation(methodNew), method_getTypeEncoding(methodNew))
        if addSuccess {
            class_replaceMethod(self, selector2, method_getImplementation(methodOrigin), method_getTypeEncoding(methodOrigin))
        } else {
            method_exchangeImplementations(methodOrigin, methodNew)
        }
    }
}
