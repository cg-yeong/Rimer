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


public class RimerRepoImplements: Domain.RimerRepoInterface {
    private let repo: UserDefaults
    private var rimerList: [Rimer] {
        get {
            var list: [Rimer]?
            if let data = repo.value(forKey: "Rimers") as? Data {
                list = try? PropertyListDecoder().decode([Rimer].self, from: data)
            }
            return list ?? []
        }
        set {
            repo.set(try? PropertyListEncoder().encode(newValue), forKey: "Rimers")
        }
    }
    
    public init(repoName: String) {
        self.repo = UserDefaults(suiteName: repoName) ?? .standard
    }
    
    public func fetch() -> RxSwift.Observable<[Domain.Rimer]> {
        return Observable.just(rimerList)
    }
    
    public func save(rimer: Domain.Rimer) -> RxSwift.Observable<Void> {
        return Observable.deferred {
            return self.repo.rx.save(obj: rimer)
        }.subscribe(on: MainScheduler())
    }
    
    public func delete(rimer: Domain.Rimer) -> RxSwift.Observable<Void> {
        <#code#>
    }
    
    public func update(rimer: Domain.Rimer) -> RxSwift.Observable<Domain.Rimer> {
        <#code#>
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
