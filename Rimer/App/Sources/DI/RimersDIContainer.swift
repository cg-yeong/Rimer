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
    
    /// New.2 Realm
    func makeRMRimerRepo() -> RimerRepoInterface {
        let repository = Repository()
        return RimerRepoImplements(repository: repository)
    }
    
    /// New.2 Realm
    func makeRMRimerUseCase() -> RimerRepoInterface {
        return RxRimerUseCaseProvier(repo: makeRMRimerRepo())
    }
    
    /// Old.1
    func makeRimerRepository() -> RimersRepositoryProtocol {
        return TimersRepsitory(storageName: "storage.rimer")
    }
    
    /// Old.1
    func makeRimersUseCase() -> RimerUseCase {
        return RimerUseCaseProvider(rimerRepo: makeRimerRepository())
    }
    
    // TODO: UseCase 변경
    func makeRimersViewModel() -> RimersViewModel {
//        return RimersViewModel(timerUseCase: makeRimersUseCase())
        return RimersViewModel(rimerUseCase: makeRMRimerUseCase())
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