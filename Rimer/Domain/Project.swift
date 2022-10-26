//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "Domain",
    dependencies: [
        .project(target: "Util", path: .relativeToRoot("Rimer/Util"))
    ]
)
