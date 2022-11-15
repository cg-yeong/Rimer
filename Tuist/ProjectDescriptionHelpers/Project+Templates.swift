import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    
    static let bundleID = "com.yeong.Rimer"
    static let iosVersion = "13.0"
    
    public static func app(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = nil,
        scripts: [TargetScript] = []
    ) -> Project {
        return self.project(
            name: name,
            product: .app,
            bundleID: bundleID + "\(name)",
            dependencies: dependencies,
            resources: resources,
            scripts: scripts
        )
    }
    
    public static func makeScheme(
        name: String
    ) -> [Scheme] {
        return [
            Scheme(
                name: "\(name)dev",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)dev"]),
                runAction: .runAction(configuration: .debug)
            )
        ]
    }
    
    public static func framework(
        name: String,
        dependencies: [TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = nil
    ) -> Project {
        return self.project(
            name: name,
            product: .framework,
            bundleID: bundleID + ".\(name)",
            dependencies: dependencies,
            resources: resources
        )
    }
    
    public static func project(
        name: String,
        product: Product,
        bundleID: String,
        schemes: [Scheme] = [],
        dependencies: [TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = nil,
        scripts: [TargetScript] = []
    ) -> Project {
        return Project(
            name: name,
            targets: [
                Target(
                    name: name,
                    platform: .iOS,
                    product: product,
                    bundleId: bundleID,
                    deploymentTarget: .iOS(targetVersion: iosVersion, devices: [.iphone, .ipad]),
                    infoPlist: .file(path: .relativeToRoot("Supporting Files/Info.plist")), // Rimer 최상위 폴더 내의 info.plist 동일참조하려고
                    sources: ["Sources/**"],
                    resources: resources,
                    scripts: scripts,
                    dependencies: dependencies
                ),
                Target(
                    name: "\(name)Tests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: bundleID,
                    deploymentTarget: .iOS(targetVersion: iosVersion, devices: [.iphone, .ipad]),
                    infoPlist: .file(path: .relativeToRoot("Supporting Files/Info.plist")),
                    sources: "Tests/**",
                    dependencies: [
                        .target(name: "\(name)")
                    ]
                )
            ]
        )
    }
}

public extension TargetDependency {
    static let kingfisher: TargetDependency = .external(name: "Kingfisher")
    static let toast: TargetDependency      = .external(name: "Toast")
    static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
    static let then: TargetDependency       = .external(name: "Then")
    static let snapKit: TargetDependency    = .external(name: "SnapKit")
    static let rxSwift: TargetDependency    = .external(name: "RxSwift")
    static let rxCocoa: TargetDependency    = .external(name: "RxCocoa")
    static let alamofire: TargetDependency  = .external(name: "Alamofire")
    static let realmSwift: TargetDependency = .external(name: "RealmSwift")
}
