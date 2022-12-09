//
//  AddRimerUseCase.swift
//  Domain
//
//  Created by root0 on 2022/10/19.
//

import Foundation
import RxSwift

public protocol FetchRimerListUseCase {
    func fetch(completion: @escaping (([Rimer]) -> Void))
}

public protocol AddRimerUseCase {
    func add(timer: Rimer, completion: @escaping ((Rimer) -> Void))
}

public protocol UpdateRimerUseCase {
    func update(timer: Rimer, completion: @escaping ((Rimer) -> Void))
}

public protocol DeleteRimerUseCase {
    func delete(timer: Rimer, completion: @escaping (() -> Void))
}

public protocol RimerUseCase: AddRimerUseCase, FetchRimerListUseCase, UpdateRimerUseCase, DeleteRimerUseCase { }

public class RimerUseCaseProvider: RimerUseCase {
    
    private let rimerRepo: RimersRepositoryProtocol
    
    public init(rimerRepo: RimersRepositoryProtocol) {
        self.rimerRepo = rimerRepo
    }
    
    public func add(timer: Rimer, completion: @escaping ((Rimer) -> Void)) {
        rimerRepo.addRimer(timer: timer) { rimer in
            print(rimer)
            completion(rimer)
        }
    }
    
    public func fetch(completion: @escaping (([Rimer]) -> Void)) {
        rimerRepo.fetchTimersList { rimers in
            completion(rimers)
        }
    }
    
    public func update(timer: Rimer, completion: @escaping ((Rimer) -> Void)) {
        rimerRepo.updateRimer(timer: timer) { rimer in
            print(rimer)
        }
    }
    
    public func delete(timer: Rimer, completion: @escaping (() -> Void)) {
        rimerRepo.deleteRimer(timer: timer) {
            print("DELETE")
        }
    }
}

public class RxRimerUseCaseProvier: RimerRepoInterface {
    public func fetch() -> RxSwift.Observable<[Rimer]> {
        rimerRxRepo.fetch()
    }
    
    public func save(rimer: Rimer) -> RxSwift.Observable<Void> {
        <#code#>
    }
    
    public func delete(rimer: Rimer) -> RxSwift.Observable<Void> {
        <#code#>
    }
    
    public func update(rimer: Rimer) -> RxSwift.Observable<Rimer> {
        <#code#>
    }
    
    
    private let rimerRxRepo: RimerRepoInterface
    
    public init(repo: RimerRepoInterface) {
        self.rimerRxRepo = repo
    }
    
}
