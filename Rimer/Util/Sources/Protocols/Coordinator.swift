//
//  Coordinator.swift
//  Util
//
//  Created by root0 on 2022/10/18.
//

import Foundation

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
