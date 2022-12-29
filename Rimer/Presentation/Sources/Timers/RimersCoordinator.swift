//
//  TimersCoordinator.swift
//  Presentation
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import UIKit

import Util
import Domain

public protocol RimersCoordinatorDependencies {
    func makeRimersViewController(actions: RimersViewModelActions) -> RimersViewController
    func createRimerVC(action: CreateViewModelAction) -> CRUDRimerVC
}


public class RimersCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    private var nav: UINavigationController
    private let dependencies: RimersCoordinatorDependencies
    
    public init(nav: UINavigationController, dependencies: RimersCoordinatorDependencies) {
        self.nav = nav
        nav.view.backgroundColor = .white
        self.dependencies = dependencies
        
    }
    
    public func start() {
        let rimerVC = dependencies.makeRimersViewController(actions: self) // RimersViewModelActions 채택
        rimerVC.coordinator = self
        self.nav.pushViewController(rimerVC, animated: false)
    }
    
    public func popVC() {
        self.nav.dismiss(animated: true)
    }
    
    deinit {
        print(#file)
    }
    
}

extension RimersCoordinator: RimersViewModelActions {
    
    public func toCreateRimer() {
        let createVC = dependencies.createRimerVC(action: self)
        createVC.coordinator = self
        createVC.modalPresentationStyle = .overFullScreen
        self.nav.present(createVC, animated: true)
    }
    
    public func toRimer(_ rimer: Domain.Rimer) {
        
    }
    
}

extension RimersCoordinator: CreateViewModelAction {
    public func toRimers() {
        self.nav.dismiss(animated: true)
    }
}

