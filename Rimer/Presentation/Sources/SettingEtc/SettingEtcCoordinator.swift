//
//  SettingEtcCoordinator.swift
//  Presentation
//
//  Created by root0 on 2022/10/18.
//

import UIKit
import Util

public protocol SettingEtcCoordinatorDependencies {
    func makeSettingEtcViewController() -> SettingEtcViewController
}

public protocol SettingsDelegate: AnyObject {
    
}

public class SettingEtcCoordinator: Coordinator {
    
    public var childCoordinators: [Util.Coordinator] = []
    private var nav: UINavigationController
    private let dpendencies: SettingEtcCoordinatorDependencies
    
    public init(nav: UINavigationController, dependencies: SettingEtcCoordinatorDependencies) {
        self.nav = nav
        self.dpendencies = dependencies
    }
    
    public func start() {
        let vc = dpendencies.makeSettingEtcViewController()
        vc.view.backgroundColor = .systemBackground
        vc.coordinator = self
        nav.navigationBar.prefersLargeTitles = true
        nav.pushViewController(vc, animated: false)
    }
    
    deinit {
        print(#file)
    }
}

extension SettingEtcCoordinator: SettingsDelegate {
    
}
