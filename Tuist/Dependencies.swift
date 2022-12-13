//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/12.
//

import ProjectDescription

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
        .rxSwift,
        .rxDataSources,
        .rxKeyboard,
        .rxGesture,
        .moya,
        .kingfisher,
        .swiftyJSON,
        .toast,
        .snapKit,
        .then,
        .alamofire
    ],
    platforms: [.iOS]
)

public extension Package {
    static let rxSwift: Package     = .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .branch("main"))
    static let rxDataSources: Package = .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources", requirement: .branch("main"))
    static let rxKeyboard: Package    = .remote(url: "https://github.com/RxSwiftCommunity/RxKeyboard.git", requirement: .upToNextMajor(from: "2.0.0"))
    static let rxGesture: Package     = .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMajor(from: "4.0.4"))
    static let moya: Package          = .remote(url: "https://github.com/Moya/Moya.git", requirement: .branch("master"))
    static let swiftyJSON: Package  = .remote(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", requirement: .upToNextMajor(from: "4.0.0"))
    static let kingfisher: Package  = .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0"))
    static let toast: Package       = .remote(url: "https://github.com/scalessec/Toast-Swift", requirement: .branch("master"))
    static let then: Package        = .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.7.0"))
    static let snapKit: Package     = .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1"))
    static let alamofire: Package   = .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.6.1"))
    static let realmSwift: Package  = .remote(url: "https://github.com/realm/realm-swift.git", requirement: .upToNextMajor(from: "10.32.3"))
    static let rxRealm: Package     = .remote(url: "https://github.com/RxSwiftCommunity/RxRealm", requirement: .upToNextMajor(from: "5.0.5"))
}
