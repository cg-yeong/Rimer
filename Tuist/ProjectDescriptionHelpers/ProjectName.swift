//
//  ProjectName.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/12.
//

import ProjectDescription

public enum Module {
    case app
    case util
    
}

extension Module {
    public var name: String {
        switch self {
        case .app:
            return "App"
        case .util:
            return "Util"
        }
    }
    
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Rimer/" + self.name)
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}
extension Module: CaseIterable {}
