import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(
    name: Module.app.name,
    dependencies: [
        Module.domain.project,
        Module.data.project,
        Module.presentation.project,
        Module.util.project
    ]
)
