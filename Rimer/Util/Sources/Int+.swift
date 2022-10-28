//
//  Int+.swift
//  Util
//
//  Created by root0 on 2022/10/28.
//

import Foundation

extension Int {
    
    public var toColonTime: String {
        get {
            let (h, m, s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
            
            let h_string = h < 10 ? "0\(h)" : "\(h)"
            let m_string = h < 10 ? "0\(m)" : "\(m)"
            let s_string = h < 10 ? "0\(s)" : "\(s)"
            
            return h > 0 ? "\(h_string):\(m_string):\(s_string)" : "\(m_string):\(s_string)"
        }
    }
}
