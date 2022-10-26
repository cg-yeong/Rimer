import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
    name: "App",
    dependencies: [
        .project(target: "Domain", path: .relativeToRoot("Rimer/Domain")),
        .project(target: "Presentation", path: .relativeToRoot("Rimer/Presentation")),
        .project(target: "Data", path: .relativeToRoot("Rimer/Data")),
        .project(target: "Util", path: .relativeToRoot("Rimer/Util"))
    ]
)
