//
//  UIButtonPlugin.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit.UIButton

extension UIButton {
    
    static let kButtonOnTappedKey = "onTapped"
    
    var onTapped: ((UIButton) -> Void)? {
        set {
            objc_setAssociatedObject(self, UIButton.kButtonOnTappedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.addTarget(self, action: #selector(onTappedAction), for: .touchUpInside)
        }
        
        get {
            return (objc_getAssociatedObject(self, UIButton.kButtonOnTappedKey) as? ((UIButton) -> Void))
        }
    }
    
    @objc func onTappedAction() {
        guard let onTappedHandler = self.onTapped else {
            return
        }
        onTappedHandler(self)
    }
}
