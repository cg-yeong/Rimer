//
//  DomainConvertibleType.swift
//  Data
//
//  Created by root0 on 2022/12/08.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}
