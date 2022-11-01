//
//  String+.swift
//  Util
//
//  Created by root0 on 2022/11/01.
//

import Foundation

extension String {
    public var fileName: String {
        self.components(separatedBy: "/").last ?? ""
    }
}
