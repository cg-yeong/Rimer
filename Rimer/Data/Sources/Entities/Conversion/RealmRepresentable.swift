//
//  RealmRepresentable.swift
//  Data
//
//  Created by root0 on 2022/12/08.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    
    var uid: UUID { get }
    
    func asRealm() -> RealmType
}
