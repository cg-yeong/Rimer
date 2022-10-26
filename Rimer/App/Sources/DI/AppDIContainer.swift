//
//  AppDIContainer.swift
//  AppTests
//
//  Created by root0 on 2022/10/18.
//

import Foundation

final class AppDIContainer {
    func makeMainDIContainer() -> MainDIContainer {
        return MainDIContainer()
    }
}
