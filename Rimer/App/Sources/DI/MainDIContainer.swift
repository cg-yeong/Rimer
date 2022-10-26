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
    
    func makeMainCoordinator(tabBarController: RimerTabBarController) -> MainCoordinator {
        return MainCoordinator(coordinator: tabBarController, dependencies: self)
    }
}

extension MainDIContainer: MainCoordinatorDependencies {
    func makeTimersCoordinator(navigationController: UINavigationController) -> Presentation.TimersCoordinator {
        let diCont = TimersDIContainer()
        return diCont.makeTimersCoordinator(navigationController: navigationController)
    }

    func makeSettingCoordinator(navigationController: UINavigationController) -> Presentation.SettingEtcCoordinator {
        let diCont = SettingsDIContainer()
        return diCont.makeSettingsCoordinator(navigationController: navigationController)
    }

}
