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
        let repository = RMRepository()
        return RimerRepoImplements(repository: repository)
    }
    
    /// New.2 Realm
    func makeRMRimerUseCase() -> RimerRepoInterface {
        return RxRimerUseCaseProvier(repo: makeRMRimerRepo())
    }
    
//    /// Old.1
//    func makeRimerRepository() -> RimersRepositoryProtocol {
//        return TimersRepsitory(storageName: "storage.rimer")
//    }
//
//    /// Old.1
//    func makeRimersUseCase() -> RimerUseCase {
//        return RimerUseCaseProvider(rimerRepo: makeRimerRepository())
//    }
    
    // TODO: UseCase 변경
    func makeRimersViewModel(actions: RimersViewModelActions) -> RimersViewModel {
//        return RimersViewModel(timerUseCase: makeRimersUseCase())
        return RimersViewModel(rimerUseCase: makeRMRimerUseCase(), actions: actions)
    }
    
    func makeCreateRimerViewModel() -> CreateRimerViewModel {
        return CreateRimerViewModel(rimerUseCase: makeRMRimerUseCase())
    }
    
    /// Rimer Coordinator 생성
    func makeRimersCoordinator(navigationController: UINavigationController) -> Presentation.RimersCoordinator {
        let timersCoordinator = RimersCoordinator(nav: navigationController, dependencies: self)
        return timersCoordinator
    }
    
}

extension RimersDIContainer: RimersCoordinatorDependencies {
    func createRimerVC() -> Presentation.CRUDRimerVC {
        return CRUDRimerVC.create(with: makeCreateRimerViewModel())
    }
    
    func makeRimersViewController(actions: RimersViewModelActions) -> Presentation.RimersViewController {
        return RimersViewController.create(with: makeRimersViewModel(actions: actions))
    }
    
    
}
