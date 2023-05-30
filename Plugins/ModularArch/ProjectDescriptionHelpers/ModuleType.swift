//
//  ModuleType.swift
//  ModularArch
//
//  Created by root0 on 2023/05/30.
//

import Foundation
import ProjectDescription

public enum ModuleType {
    case app
    case feature
    case core
    case shared
    
    public var MODULE_SOURCE: String {
        switch self {
        case .app:
            return ModularArchiSetting._APP_PATH + ModularArchiSetting._SOURCES_PATH
        case .feature:
            return ModularArchiSetting._FEATURE_PATH + ModularArchiSetting._SOURCES_PATH
        case .core:
            return ModularArchiSetting._CORE_PATH + ModularArchiSetting._SOURCES_PATH
        case .shared:
            return ModularArchiSetting._SHARED_PATH + ModularArchiSetting._SOURCES_PATH
        }
    }
    
    public func make(modules names: [String]) -> [String] {
        switch self {
        case .app:
            return names.map { name in ModularArchiSetting._APP_PATH + "/Sources/\(name)/**" }
        case .feature:
            return names.map { name in ModularArchiSetting._FEATURE_PATH + "/Sources/\(name)/**" }
        case .core:
            return names.map { name in ModularArchiSetting._CORE_PATH + "/Sources/\(name)/**" }
        case .shared:
            return names.map { name in ModularArchiSetting._SHARED_PATH + "/Sources/\(name)/**" }
        }
    }
}
