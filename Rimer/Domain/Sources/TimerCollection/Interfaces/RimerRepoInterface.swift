//
//  RimerRepoInterface.swift
//  Domain
//
//  Created by root0 on 2022/12/06.
//

import Foundation
import RxSwift

public protocol RimerRepoInterface {
    
    func fetch() -> Observable<[Rimer]>
    func save(rimer: Rimer) -> Observable<Void>
    func delete(rimer: Rimer) -> Observable<Void>
    func update(rimer: Rimer) -> Observable<Rimer>
    
}
