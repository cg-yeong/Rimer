//
//  RepositoryUserDefaults.swift
//  Data
//
//  Created by root0 on 2022/12/06.
//

import Foundation
import RxSwift

protocol AbstractRepsitory {
    associatedtype T
    func query() -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}
