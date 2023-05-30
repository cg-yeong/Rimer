//
//  Dependency.swift
//  ModularArch
//
//  Created by root0 on 2023/05/30.
//

import Foundation
import ProjectDescription

public enum Dependency {
    public enum Framework {
        public static let feature: TargetDependency = .project(target: "Feature", path: .relativeToRoot(ModularArchiSetting._FEATURE_PATH))
        public static let core: TargetDependency = .project(target: "Core", path: .relativeToRoot(ModularArchiSetting._CORE_PATH))
        public static let shared: TargetDependency = .project(target: "Shared", path: .relativeToRoot(ModularArchiSetting._SHARED_PATH))
    }
    
    public enum DemoFramework {
        public static let feature: TargetDependency = .project(target: "DemoFeature", path: .relativeToRoot(ModularArchiSetting._FEATURE_PATH))
    }
    
    public enum AppExtension {
        public static let NotificationService: TargetDependency = .target(name: "NotificationService")
    }
    
    public enum SPM {
        public static let Rxswift: TargetDependency              = .external(name: "RxSwift")
        public static let Rxcocoa: TargetDependency              = .external(name: "RxCocoa")
        public static let Rxdatasources: TargetDependency        = .external(name: "RxDataSources")
        public static let Alamofire: TargetDependency            = .external(name: "Alamofire")
        public static let Moya: TargetDependency                 = .external(name: "Moya")
        public static let Snapkit: TargetDependency              = .external(name: "SnapKit")
        public static let Then: TargetDependency                 = .external(name: "Then")
        public static let Kingfisher: TargetDependency           = .external(name: "Kingfisher")
        public static let Rxgesture: TargetDependency            = .external(name: "RxGesture")
        public static let Swiftyjson: TargetDependency           = .external(name: "SwiftyJSON")
        public static let Toast: TargetDependency                = .external(name: "Toast")
        public static let Beaverlog: TargetDependency            = .external(name: "SwiftyBeaver")
        public static let Reachability: TargetDependency         = .external(name: "Reachability")
        public static let Sweeterswift: TargetDependency         = .external(name: "SweeterSwift") // 슬라이더 사용하기 위해 다운로드
        public static let SocketIO: TargetDependency             = .external(name: "SocketIO") // socket io
    }
}
