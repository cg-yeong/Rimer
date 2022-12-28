//
//  TimersCoordinator.swift
//  Presentation
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import Util
import UIKit

public protocol RimersCoordinatorDependencies {
    func makeRimersViewController() -> RimersViewController
    func createRimerVC() -> CRUDRimerVC
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
        let rimerVC = dependencies.makeRimersViewController()
        rimerVC.coordinator = self
//        timerVC.navigationItem.title = "라이머"
        self.nav.pushViewController(rimerVC, animated: false)
    }
    
    public func crudStart() {
        
    }
    
    deinit {
        print(#file)
    }
    
}
