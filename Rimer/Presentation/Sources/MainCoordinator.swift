//
//  AppCoordinator.swift
//  App
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import UIKit
import Util

public protocol MainCoordinatorDependencies { // tab Bar Coordis
    func makeRimerCoordinator(navigationController: UINavigationController) -> RimersCoordinator
    func makeSettingsCoordinator(navigationController: UINavigationController) -> SettingEtcCoordinator
    
}

public class MainCoordinator: Coordinator {
    
    public var childCoordinators: [Coordinator] = []
    public var coordinator: RimerTabBarController
    private let dependencies: MainCoordinatorDependencies
    
    private var nav = {
        let nav = UINavigationController()
        nav.setToolbarHidden(true, animated: false)
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
    
    
    public init(coordinator: RimerTabBarController, dependencies: MainCoordinatorDependencies) {
        self.coordinator = coordinator
        self.dependencies = dependencies
    }
    
    public func start() {
        serviceInit()
    }
    
    func serviceInit() {
        let rimeVC = nav()
        let settingsVC = nav()
        
        let rimers = dependencies.makeRimerCoordinator(navigationController: rimeVC)
        let setts = dependencies.makeSettingsCoordinator(navigationController: settingsVC)
        
        rimeVC.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "clock.circle"), selectedImage: UIImage(systemName: "clock.circle.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.circle"), selectedImage: UIImage(systemName: "gearshape.circle.fill"))
        
        childCoordinators = [rimers, setts]
        
        coordinator.viewControllers = [rimeVC, settingsVC]
        coordinator.modalPresentationStyle = .fullScreen
        coordinator.selectedIndex = 0
        rimers.start()
        setts.start()
    }
    
    
}
