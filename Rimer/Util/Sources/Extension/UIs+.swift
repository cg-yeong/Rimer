//
//  UIs+.swift
//  Util
//
//  Created by root0 on 2022/11/01.
//

import UIKit

extension UITextField {
    
    public func addLeftPaddingView(left: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.bounds.height))
        self.leftViewMode = .always
    }
    
    convenience init(leftPadding: CGFloat) {
        self.init()
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 0))
        self.leftViewMode = .always
    }
}

