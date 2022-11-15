import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.framework(
    name: "Util",
    dependencies: [
        .kingfisher, .swiftyJSON, .toast, .snapKit, .then, .rxSwift, .rxCocoa, .alamofire, .realmSwift
    ]
)

