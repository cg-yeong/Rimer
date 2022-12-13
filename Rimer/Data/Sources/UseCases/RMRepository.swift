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
import RxRealm

import Domain

protocol AbstractRepsitory {
    associatedtype T
    func queryAll() -> Observable<[T]>
    func query(with predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}

public class RMRepository: AbstractRepsitory {
    typealias T = Rimer // T == T.RealmType.DomainType, T.RealmType: Object
    private let configuration: Realm.Configuration
//    private let scheduler: RunLoopThreadScheduler
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
        let name = "com.Rimer.Realm.Repository"
//        self.scheduler = RunLoopThreadScheduler(threadName: name)
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }
    func queryAll() -> RxSwift.Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
        }
        .subscribe(on: MainScheduler())
    }
    
    func query(with predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> RxSwift.Observable<[T]> {
        return .just([])
    }
    
    func save(entity: T) -> RxSwift.Observable<Void> {
        return .just(())
    }
    
    func delete(entity: T) -> RxSwift.Observable<Void> {
        return .just(())
    }
    
    
    
    
}
