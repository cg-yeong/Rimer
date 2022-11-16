import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(name: Module.app.name,
                          dependencies: [Module.domain,
                                         Module.data,
                                         Module.presentation,
                                         Module.util
                                        ].map(\.project),
                          resources: .default
)
