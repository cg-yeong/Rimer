//
//  SceneDelegate.swift
//  App
//
//  Created by root0 on 2022/10/12.
//

import UIKit
import Presentation
import Util

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    var appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        let vc = RimerTabBarController()
        window.rootViewController = vc
        
        appFlowCoordinator = AppFlowCoordinator(tabBar: vc, appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}
