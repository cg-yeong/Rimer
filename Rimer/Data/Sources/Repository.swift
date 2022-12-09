//
//  Repository.swift
//  Data
//
//  Created by root0 on 2022/12/06.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

import Domain

protocol AbstractRepsitory {
    associatedtype T
    func queryAll() -> Observable<[T]>
    func query(with predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}

public class Repository: AbstractRepsitory {
    typealias T = Rimer
//   T: RealmRepresentable where T == T.RealmType.DomainType, T.RealmType: Object
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    func queryAll() -> RxSwift.Observable<[T]> {
        <#code#>
    }
    
    func query(with predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> RxSwift.Observable<[T]> {
        <#code#>
    }
    
    func save(entity: T) -> RxSwift.Observable<Void> {
        <#code#>
    }
    
    func delete(entity: T) -> RxSwift.Observable<Void> {
        <#code#>
    }
    
    
    
    
}
