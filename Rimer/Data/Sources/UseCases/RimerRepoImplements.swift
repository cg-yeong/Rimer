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
    
    private let repository: RMRepository
    
    public init(repository: RMRepository) {
        self.repository = repository
    }
    
    public func fetch() -> RxSwift.Observable<[Domain.Rimer]> {
        return repository.queryAll()
    }
    
    public func save(rimer: Domain.Rimer) -> RxSwift.Observable<Void> {
        return repository.save(entity: rimer)
    }
    
    public func delete(rimer: Domain.Rimer) -> RxSwift.Observable<Void> {
        return repository.delete(entity: rimer)
    }
    
    public func update(rimer: Domain.Rimer) -> RxSwift.Observable<Domain.Rimer> {
        return .just(Rimer.init())
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
