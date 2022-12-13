import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.framework(
    name: Module.util.name,
    dependencies: [
        .kingfisher,
        .swiftyJSON,
        .toast,
        .rxSwift,
        .rxCocoa,
        .rxKeyboard,
        .rxGesture,
        .snapKit,
        .then,
        .rxRelay
    ],
    resources: .default
)

