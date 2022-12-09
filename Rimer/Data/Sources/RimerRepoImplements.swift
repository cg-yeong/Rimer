//
//  RimerRepoImplements.swift
//  Data
//
//  Created by root0 on 2022/12/06.
//

import Foundation
import RxSwift
import RxCocoa

import Domain
import Util
import Realm
import RealmSwift


public final class RimerRepoImplements: Domain.RimerRepoInterface {
    
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func fetch() -> RxSwift.Observable<[Domain.Rimer]> {
        return <#Observable<[Rimer]>#>
    }
    
    public func save(rimer: Domain.Rimer) -> RxSwift.Observable<Void> {
        return .just(())
    }
    
    public func delete(rimer: Domain.Rimer) -> RxSwift.Observable<Void> {
        return .just(())
    }
    
    public func update(rimer: Domain.Rimer) -> RxSwift.Observable<Domain.Rimer> {
        return <#Observable<Rimer>#>
    }
    
    
}

extension Reactive where Base == UserDefaults {
    func save<T: Codable>(obj: T) -> RxSwift.Observable<Void> {
        return Observable.create { observer in
            do {
//                self.base.set(<#T##value: Any?##Any?#>, forKey: "Rimers")
                var list: [T]?
                if let data = self.base.value(forKey: "Rimers") as? Data {
                    list = try PropertyListDecoder().decode([T].self, from: data)
                }
                self.base.set(try PropertyListEncoder().encode(obj), forKey: "Rimers")
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
