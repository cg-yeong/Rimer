//
//  SettingsDIContainer.swift
//  App
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import Presentation
import Domain
import Data
import UIKit

final class SettingsDIContainer {
    
    func makeSettingViewModel() -> SettingEtcViewModel {
        return SettingEtcViewModel()
    }
    
    
    func makeSettingsCoordinator(navigationController: UINavigationController) -> SettingEtcCoordinator {
        return SettingEtcCoordinator(nav: navigationController, dependencies: self)
    }
}

extension SettingsDIContainer: SettingEtcCoordinatorDependencies {
    
    func makeSettingEtcViewController() -> Presentation.SettingEtcViewController {
        return SettingEtcViewController(dependency: makeSettingViewModel())
    }
    
}
