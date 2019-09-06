//
//  UIColorPlugin.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(rgb: CGFloat, a: CGFloat = 1.0) {
        self.init(red: rgb / 255.0, green: rgb / 255.0, blue: rgb / 255.0, alpha: a)
    }
    
    convenience init(hex: String, a: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            self.init()
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: a)
        }
    }
}

extension UIColor {
    static let tcl_4a4a4a = UIColor(hex: "4a4a4a") // 文字主色调
    static let tcl_999999 = UIColor(hex: "999999") // 辅助文字色调
    static let tcl_c5c5c5 = UIColor(hex: "c5c5c5") // 置灰控件色调
    static let tcl_d5d5d5 = UIColor(hex: "d5d5d5") // tableViewHeader文字色调
    static let tcl_5c5558 = UIColor(hex: "535558") // 屎黄色
    static let tcl_b88e67 = UIColor(hex: "b88e67") // 开关启动颜色
    static let tcl_e6e6e6 = UIColor(hex: "e6e6e6") // 分割线颜色
    static let tcl_f7f7f7 = UIColor(hex: "f7f7f7") // 背景底色，灰白
    static let tcl_a4a4a4 = UIColor(hex: "a4a4a4") // 副标题颜色
}
