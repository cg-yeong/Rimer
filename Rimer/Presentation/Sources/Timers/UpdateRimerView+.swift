//
//  UpdateRimerView+.swift
//  Presentation
//
//  Created by root0 on 2022/11/02.
//

import Foundation
import UIKit

extension UpdateRimerView {
    
}

extension UpdateRimerView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
