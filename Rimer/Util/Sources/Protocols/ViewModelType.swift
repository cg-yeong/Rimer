//
//  ViewModelType.swift
//  Util
//
//  Created by root0 on 2022/10/20.
//

import Foundation

public protocol ViewModelTypeInput {
    
}

public protocol ViewModelTypeOutput {
    
}

public protocol ViewModelTypeProtocol: ViewModelTypeInput, ViewModelTypeOutput { }

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
