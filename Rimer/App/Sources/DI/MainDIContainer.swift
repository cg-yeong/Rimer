//
//  MainDIContainer.swift
//  AppTests
//
//  Created by root0 on 2022/10/18.
//

import UIKit
import Presentation
import Util

class MainDIContainer {
    
    public init() {}
    
    /// MainCoordinator 생성
    func makeMainCoordinator(tabBarController: RimerTabBarController) -> MainCoordinator {
        return MainCoordinator(coordinator: tabBarController, dependencies: self)
    }
}

extension MainDIContainer: MainCoordinatorDependencies {
    
    func makeRimerCoordinator(navigationController: UINavigationController) -> Presentation.RimersCoordinator {
        let diContainer = RimersDIContainer()
        return diContainer.makeRimersCoordinator(navigationController: navigationController)
    }

    func makeSettingsCoordinator(navigationController: UINavigationController) -> Presentation.SettingEtcCoordinator {
        let diCont = SettingsDIContainer()
        return diCont.makeSettingsCoordinator(navigationController: navigationController)
    }

}
