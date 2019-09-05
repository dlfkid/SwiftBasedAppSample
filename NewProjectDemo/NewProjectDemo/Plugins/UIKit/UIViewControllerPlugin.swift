//
//  File.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func custom_viewWillAppear(animate: Bool) {
        print("Presenting View Controller: \(NSStringFromClass(self.classForCoder))")
        self.custom_viewWillAppear(animate: animate)
    }
    
}
