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
        .kingfisher,
        .swiftyJSON,
        .toast,
        .then,
        .snapKit,
        .rxSwift,
        .alamofire
    ],
    platforms: [.iOS]
)

public extension Package {
    static let kingfisher: Package  = .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0"))
    static let swiftyJSON: Package  = .remote(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", requirement: .upToNextMajor(from: "4.0.0"))
    static let toast: Package       = .remote(url: "https://github.com/scalessec/Toast-Swift", requirement: .branch("master"))
    static let then: Package        = .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.7.0"))
    static let snapKit: Package     = .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .upToNextMajor(from: "5.0.1"))
    static let rxSwift: Package     = .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .branch("main"))
    static let alamofire: Package   = .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.6.1"))
}
