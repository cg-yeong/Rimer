//
//  RimerTabBarController.swift
//  Presentation
//
//  Created by root0 on 2022/10/20.
//

import UIKit

public class RimerTabBarController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.backgroundColor = .systemBackground
        tabBar.unselectedItemTintColor = .label
        tabBar.tintColor = .blue
    }
}


extension RimerTabBarController: UITabBarControllerDelegate {
    
}
