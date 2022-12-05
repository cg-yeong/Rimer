//
//  AppAppearance.swift
//  App
//
//  Created by root0 on 2022/12/05.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(red: 37/255.0, green: 37/255.0, blue: 37/255.0, alpha: 1)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        } else {
            UINavigationBar.appearance().barTintColor = .black
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

extension UINavigationController {
    @objc open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
