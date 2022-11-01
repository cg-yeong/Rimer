//
//  UIViewControllerPreview.swift
//  Util
//
//  Created by root0 on 2022/11/01.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI
public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    public let viewController: ViewController

    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Context) -> ViewController {
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
    
}
#endif
