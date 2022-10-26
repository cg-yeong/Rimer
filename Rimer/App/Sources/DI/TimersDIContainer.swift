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

final class TimersDIContainer {
    
    func makeTimerRepository() -> TimersRepositoryProtocol {
        return TimersRepsitory(storageName: "storage.rimer")
    }
    
    func makeTimersUseCase() -> RimerUseCase {
        return RimerUseCaseProvider(rimerRepo: makeTimerRepository())
    }
    
    func makeTimersViewModel() -> TimersViewModel {
        return TimersViewModel(timerUseCase: makeTimersUseCase())
    }
    
    func makeTimersCoordinator(navigationController: UINavigationController) -> Presentation.TimersCoordinator {
        let timersCoordinator = TimersCoordinator(nav: navigationController, dependencies: self)
        return timersCoordinator
    }
    
}

extension TimersDIContainer: TimersCoordinatorDependencies {
    func makeTimersViewController() -> Presentation.TimersViewController {
        return TimersViewController.create(with: makeTimersViewModel())
    }
    
    
}
