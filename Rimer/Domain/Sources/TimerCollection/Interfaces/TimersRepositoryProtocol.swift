//
//  TimersRepositoryProtocol.swift
//  Domain
//
//  Created by root0 on 2022/10/19.
//

import Foundation
import RxSwift

public protocol TimersRepositoryProtocol {
    
    func fetchTimersList(completion: @escaping ([Rimer]) -> Void)
//    func fetchTimers() -> Observable<[Rimer]>
    
    func addRimer(timer: Rimer, completion: @escaping ((Rimer?) -> Void))
//    func addTimer(timer: Rimer) -> Observable<Void>
    
    func updateRimer(timer: Rimer, completion: @escaping ((Rimer) -> Void))
//    func updateRimer(timer: Rimer) -> Observable<Rimer>
    
    func deleteRimer(timer: Rimer, completion: @escaping () -> Void)
//    func deleteRimer(timer: Rimer) -> Observable<Void>
    
}
