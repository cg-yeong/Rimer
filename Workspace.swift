//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/12.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "Rimer", projects: [
    .relativeToRoot("Rimer/App"),
    .relativeToRoot("Rimer/Util")
])
