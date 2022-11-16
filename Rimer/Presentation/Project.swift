//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/18.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: Module.presentation.name,
    dependencies: [
        Module.util.project,
        Module.domain.project,
        .rxSwift,
        .rxCocoa
    ],
    resources: .default
)
