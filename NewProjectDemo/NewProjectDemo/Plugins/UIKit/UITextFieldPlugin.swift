//
//  UITextFieldPlugin.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit

@IBDesignable
extension UITextField {
    
    @IBInspectable
    var leftPadding: CGFloat {
        get {
            return leftView != nil ? leftView!.frame.size.width : 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable
    var rigthPadding: CGFloat {
        get {
            return rightView != nil ? rightView!.frame.size.width : 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    func addPaddingRightButton(_ image: UIImage, selectedImage: UIImage? = nil, padding: CGFloat, onTap: ((UIButton) -> Void)? = nil) {
        let button = UIButton()
        button.isUserInteractionEnabled = (onTap != nil)
        button.setImage(image, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.contentMode = .center
        button.sizeToFit()
        
        self.rightView = button
        self.rightView?.frame.size = CGSize(width: button.frame.size.width + padding, height: button.frame.size.height)
        self.rightViewMode = .always
        
        guard let onTapHandler = onTap else {
            return
        }
        
        button.onTapped = { (button) in
            onTapHandler(button)
        }
    }
}
