//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: Module.domain.name,
    dependencies: [
        Module.util.project
    ]
)
