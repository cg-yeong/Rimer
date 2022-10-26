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
    func makeTimersCoordinator(navigationController: UINavigationController) -> TimersCoordinator
    func makeSettingCoordinator(navigationController: UINavigationController) -> SettingEtcCoordinator
    
}

public class MainCoordinator: Coordinator {
    
    var coordinator: RimerTabBarController
    private let dpencies: MainCoordinatorDependencies
    private var nav = {
        let nav = UINavigationController()
        nav.setToolbarHidden(true, animated: false)
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
    public var childCoordinators: [Coordinator] = []
    
    
    public init(coordinator tabBarController: RimerTabBarController, dependencies: MainCoordinatorDependencies) {
        self.coordinator = tabBarController
        self.dpencies = dependencies
    }
    
    public func start() {
        tabsInit()
    }
    
    func tabsInit() {
        let timersVC = nav()
        let settingsVC = nav()
        
        let timers = dpencies.makeTimersCoordinator(navigationController: timersVC)
        let setts = dpencies.makeSettingCoordinator(navigationController: settingsVC)
        
        timersVC.tabBarItem = UITabBarItem(title: "타이머", image: UIImage(systemName: "clock.circle"), selectedImage: UIImage(systemName: "clock.circle.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.circle"), selectedImage: UIImage(systemName: "gearshape.circle.fill"))
        
        childCoordinators = [timers, setts]
        
        coordinator.viewControllers = [timersVC, settingsVC]
//        coordinator.modalPresentationStyle = .de
        coordinator.selectedIndex = 0
        timers.start()
        setts.start()
    }
    
    
}
