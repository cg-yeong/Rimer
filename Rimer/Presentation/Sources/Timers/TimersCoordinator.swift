//
//  TimersCoordinator.swift
//  Presentation
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import Util
import UIKit

public protocol TimersCoordinatorDependencies {
    func makeTimersViewController() -> TimersViewController
}

protocol TimersDelegate: AnyObject {
    func tapTimerBtn()
}

public class TimersCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    private var nav: UINavigationController
    private let dpendencies: TimersCoordinatorDependencies
    
    public init(nav: UINavigationController, dependencies: TimersCoordinatorDependencies) {
        self.nav = nav
        self.dpendencies = dependencies
        
    }
    
    public func start() {
        let timerVC = dpendencies.makeTimersViewController()
        
        timerVC.view.backgroundColor = .systemBackground
        timerVC.coordi = self
        self.nav.pushViewController(timerVC, animated: false)
    }
    
    deinit {
        print(#file)
    }
    
}

extension TimersCoordinator: TimersDelegate {
    func tapTimerBtn() {
        
    }
    
    
}
