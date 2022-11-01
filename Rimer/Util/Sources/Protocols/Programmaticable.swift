//
//  Programmaticable.swift
//  Util
//
//  Created by chuchu on 2022/09/16.
//

import UIKit

public protocol Programmaticable {
    var fileName: String { get set }
    func addComponent()
    func setConstraints()
    func bind()
}
