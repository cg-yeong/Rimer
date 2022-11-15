//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/12.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "Rimer", projects: [
    Module.app.path,
    Module.domain.path,
    Module.presentation.path,
    Module.data.path,
    Module.util.path
])
