//
//  File.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit

extension UIViewController: Initialize {
    
    static func awake() {
        UIViewController.swizzleInstanceMethod(selector1: #selector(UIViewController.viewWillAppear(_:)), selector2: #selector(UIViewController.custom_viewWillAppear(animate:)))
    }
    
    @objc func custom_viewWillAppear(animate: Bool) {
        print("Presenting View Controller: \(NSStringFromClass(self.classForCoder))")
        self.custom_viewWillAppear(animate: animate)
    }
    
}
