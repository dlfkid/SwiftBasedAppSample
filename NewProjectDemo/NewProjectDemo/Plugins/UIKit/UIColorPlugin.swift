//
//  UIColorPlugin.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    
    static let tint = UIColor(r: 34, g: 175, b: 197)
    static let appLightGray = UIColor(r: 239, g: 239, b: 244)
    static let silverGray = UIColor(r: 241, g: 239, b: 239)
    static let tableViewBackground = UIColor(rgb: 238)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    convenience init(rgb: CGFloat, a: CGFloat = 1.0) {
        self.init(red: rgb / 255.0, green: rgb / 255.0, blue: rgb / 255.0, alpha: a)
    }
    
    convenience init(hex: String, a: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            self.init()
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: a)
        }
    }
}
