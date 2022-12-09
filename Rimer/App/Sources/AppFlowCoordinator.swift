//
//  AppCoordinator.swift
//  AppTests
//
//  Created by root0 on 2022/10/18.
//

import Foundation
import Presentation
import Domain
import Util
import UIKit

/// 코디네이터는 DI를 만들고 DI를 통해 Coordinator를 만든 후 뷰를 올려준다.
public class AppFlowCoordinator: Coordinator {
    public var childCoordinators: [Util.Coordinator] = []
    
    var tabBarController: RimerTabBarController
    private let appDIContainer: AppDIContainer
    
    init(tabBar: RimerTabBarController, appDIContainer: AppDIContainer) {
        self.tabBarController = tabBar
        self.appDIContainer = appDIContainer
    }
    
    public func start() {
        let mainDIC = appDIContainer.makeMainDIContainer()
        let mainCoordi = mainDIC.makeMainCoordinator(tabBarController: tabBarController)
        mainCoordi.start()
    }
    
}


