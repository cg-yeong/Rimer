//
//  Collection+.swift
//  Util
//
//  Created by root0 on 2022/11/02.
//

import Foundation

extension Collection {
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
