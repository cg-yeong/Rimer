import ProjectDescription
import ProjectDescriptionHelpers
/*
                +-------------+
                |             |
                |     App     | Contains Rimer App target and Rimer unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let project = Project.app(
    name: "App",
    dependencies: [
        .project(target: "Util", path: .relativeToRoot("Rimer/Util"))
    ]
)
