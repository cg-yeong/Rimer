//
//  Extensions.swift
//  ModularArch
//
//  Created by root0 on 2023/05/30.
//

import Foundation
import ProjectDescription

public extension Project {
    static func _makeFrameworkTargets(
        name: String,
        product: Product = .framework,
        moduleType: ModuleType,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        headers: Headers? = nil,
        settings: Settings? = nil
    ) -> Target {
        
        let path: Path = .relativeToRoot(moduleType.MODULE_SOURCE)
        
        let target = Target(
            name: name,
            platform: .iOS,
            product: product,
            bundleId: "\(ModularArchiSetting._BUNDLE_ID).\(name)",
            deploymentTarget: .iOS(targetVersion: ModularArchiSetting._OS_PLATFORM_VERSION, devices: [.ipad, .iphone]),
            infoPlist: ModularArchiSetting._INFOLIST,
            sources: sources ?? [.glob(path, excluding: nil)],
            resources: resources ?? [.glob(pattern: path, excluding: [
                .relativeToRoot(moduleType.MODULE_SOURCE + "/*.swift")
            ])],
            headers: nil,
            dependencies: dependencies,
            settings: settings
        )
        
        return target
    }
    
    static func _makeAppTargets(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> [Target] {
        
        let platform: Platform = platform
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(ModularArchiSetting._BUNDLE_ID)",
            infoPlist: ModularArchiSetting._INFOLIST,
            sources: [
                .glob(.relativeToRoot(ModularArchiSetting._APP_PATH + ModularArchiSetting._SOURCES_PATH))
            ],
            resources: [
                .glob(pattern: .relativeToRoot(ModularArchiSetting._APP_PATH + ModularArchiSetting._RESOURCES_PATH))
            ],
            dependencies: dependencies,
            settings: .settings(base: ModularArchiSetting._DEFAULT_PROJECT_SETTING, configurations: [], defaultSettings: .recommended)
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(ModularArchiSetting._BUNDLE_ID).\(name)Tests",
            infoPlist: .default,
            sources: [
                .glob(.relativeToRoot(ModularArchiSetting._APP_PATH + "/Tests/**"), excluding: nil)
            ],
            dependencies: [
                .target(name: "\(name)")
            ],
            settings: .settings(base: .init().codeSignIdentityAppleDevelopment(), configurations: [], defaultSettings: .recommended)
        )
        
        return [mainTarget, testTarget]
    }
    
    static func _makeDemoAppTargets(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency]
    ) -> [Target] {
        
        let platform: Platform = platform
        var targetPath: String = "/" + name
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: ModularArchiSetting._BUNDLE_ID,
            infoPlist: ModularArchiSetting._INFOLIST,
            sources: [
                .glob(.relativeToRoot(ModularArchiSetting._DEMOAPP_PATH + targetPath + ModularArchiSetting._SOURCES_PATH))
            ],
            resources: [
                .glob(pattern: .relativeToRoot(ModularArchiSetting._DEMOAPP_PATH + targetPath + ModularArchiSetting._RESOURCES_PATH))
            ],
            dependencies: dependencies,
            settings: .settings(base: ModularArchiSetting._DEFAULT_PROJECT_SETTING, configurations: [], defaultSettings: .recommended)
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(ModularArchiSetting._BUNDLE_ID).\(name)Tests",
            infoPlist: .default,
            sources: [
                .glob(.relativeToRoot(ModularArchiSetting._DEMOAPP_PATH + targetPath + "/Tests/**"), excluding: nil)
            ],
            dependencies: [.target(name: "\(name)")],
            settings: .settings(base: SettingsDictionary().codeSignIdentityAppleDevelopment(), configurations: [], defaultSettings: .recommended)
        )
        
        return [mainTarget, testTarget]
    }
}

public extension SourceFilesList {
    static func sources(path: [String]) -> SourceFilesList {
        let globs: [SourceFileGlob] = path.map {
            .glob(.relativeToRoot($0), excluding: nil)
        }
        
        return SourceFilesList(globs: globs)
    }
}

public extension ResourceFileElements {
    static func resources(path: [String]) -> ResourceFileElements {
        let globs: [ResourceFileElement] = path.map {
            ResourceFileElement.glob(pattern: .relativeToRoot($0))
        }
        
        return ResourceFileElements(resources: globs)
    }
}
