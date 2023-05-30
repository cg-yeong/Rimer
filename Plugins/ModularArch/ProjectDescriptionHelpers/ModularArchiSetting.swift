//
//  ModularArchiSetting.swift
//  ModularArch
//
//  Created by root0 on 2023/05/30.
//

import Foundation
import ProjectDescription

public enum ModularArchiSetting {
    
    // MARK: - App Configuration
    public static let _BUILD: SettingValue = "0"
    public static let _VERSION: SettingValue = "1.0.001"
    public static let _PLATFORM: Platform = .iOS
    public static let _OS_PLATFORM_VERSION: String = "14.0"
    //public static let _TEAM: String
    public static let _BUNDLE_ID: String = "com.yeong.Rimer"
    
    public static let _PROJECT_NAME: String = "RimerProject"
    public static let _PROJECT_PATH: String = "Projects"
    public static let _RESOURCES_PATH: String = "/Resources/**"
    public static let _SOURCES_PATH: String = "/Sources/**"
    
    public static let _APP_PATH: String = _PROJECT_PATH + "/App"
    public static let _DEMOAPP_PATH: String = _PROJECT_PATH + "/DemoApp"
    public static let _FEATURE_PATH: String = _PROJECT_PATH + "/Feature"
    public static let _CORE_PATH: String = _PROJECT_PATH + "/Core"
    public static let _SHARED_PATH: String = _PROJECT_PATH + "/Shared"
    
    public static let _TEST_PATH: String = _APP_PATH + "/Tests"
    public static let _APPEXTENSION_PATH: String = _APP_PATH + "/AppExtensions/NotificationService"
    
    public static let _ENTITLEMENTS: String = _APP_PATH + "/Supporting File/entitlements/Rimer.entitlements"
    public static let _INFOLIST: InfoPlist = .file(path: .relativeToRoot(_PROJECT_PATH + "/RimerInfo.plist"))
    
    
    // MARK: - Settings
    public static var _DEFAULT_PROJECT_SETTING: SettingsDictionary = .init().codeSignIdentityAppleDevelopment()
        .merging([
            "TARGETED_DEVICE_FAMILY" : "1,2",
            "IPHONEOS_DEPLOYMENT_TARGET" : .string(_OS_PLATFORM_VERSION),
            "MARKETING_VERSION" : ModularArchiSetting._VERSION,
            "CURRENT_PROJECT_VERSION" : ModularArchiSetting._BUILD,
            "SDKROOT" : "iphoneos",
            "OTHER_LDFLAGS" : "-ObjC",
            "DEBUG_INFORMATION_FORMAT" : "dwaraf-with-dsym"
        ])
    public static var _DEFAULT_EXTENSION_SETTING: SettingsDictionary = .init().codeSignIdentityAppleDevelopment()
        .merging([
            "TARGETED_DEVICE_FAMILY" : "1,2",
            "IPHONEOS_DEPLOYMENT_TARGET" : .string(_OS_PLATFORM_VERSION),
            "MARKETING_VERSION" : ModularArchiSetting._VERSION,
            "CURRENT_PROJECT_VERSION" : ModularArchiSetting._BUILD,
        ])
    public static func makeDebugSetting() -> SettingsDictionary {
        return _DEFAULT_PROJECT_SETTING.merging([
            "SWIFT_COMPILATION_MODE":"singlefile",
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG",
            "OTHER_SWIFT_FLAGS" : "$(inherited) -D DEBUG",
        ])
    }
}
