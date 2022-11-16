//
//  ProjectName.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2022/10/12.
//

import ProjectDescription

public enum Module {
    case app
    
    // Repository, DataStore
    case data
    
    // Presentation
    case presentation
    
    // Domain
    case domain
    
    // Design, UIs
    case util
    
}

extension Module {
    public var name: String {
        switch self {
        case .app:
            return "App"
        case .util:
            return "Util"
        case .data:
            return "Data"
        case .presentation:
            return "Presentation"
        case .domain:
            return "Domain"
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
