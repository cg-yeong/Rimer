//
//  TimersDIContainer.swift
//  AppTests
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import Presentation
import Domain
import Data
import UIKit

final class RimersDIContainer {
    
    func makeRimerRepository() -> RimersRepositoryProtocol {
        return TimersRepsitory(storageName: "storage.rimer")
    }
    
    func makeRimersUseCase() -> RimerUseCase {
        return RimerUseCaseProvider(rimerRepo: makeRimerRepository())
    }
    
    func makeRimersViewModel() -> RimersViewModel {
        return RimersViewModel(timerUseCase: makeRimersUseCase())
    }
    
    /// Rimer Coordinator 생성
    func makeRimersCoordinator(navigationController: UINavigationController) -> Presentation.RimersCoordinator {
        let timersCoordinator = RimersCoordinator(nav: navigationController, dependencies: self)
        return timersCoordinator
    }
    
}

extension RimersDIContainer: RimersCoordinatorDependencies {
    func makeRimersViewController() -> Presentation.RimersViewController {
        return RimersViewController.create(with: makeRimersViewModel())
    }
    
    
}
