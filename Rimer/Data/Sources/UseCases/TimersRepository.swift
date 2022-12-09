//
//  TimersRepository.swift
//  Data
//
//  Created by root0 on 2022/10/20.
//

import Foundation
import Domain
import Util
import RxSwift
import RxCocoa

public class TimersRepsitory: RimersRepositoryProtocol {
    
    private let storage: UserDefaults
    var rimerList: [Rimer] {
        get {
            var list: [Rimer]?
            if let data = storage.value(forKey: "Rimers") as? Data {
                list = try? PropertyListDecoder().decode([Rimer].self, from: data)
            }
            return list ?? []
        }
        set {
            storage.set(try? PropertyListEncoder().encode(newValue), forKey: "Rimers")
        }
    }
    
    public init(storageName: String) {
        self.storage = UserDefaults(suiteName: storageName) ?? UserDefaults.standard
    }
    
    public func fetchTimersList(completion: @escaping ([Rimer]) -> Void) {
        completion(rimerList)
    }
    
    public func addRimer(timer: Domain.Rimer, completion: @escaping ((Domain.Rimer) -> Void)) {
        rimerList.append(timer)
        
        completion(timer)
    }
    
    public func updateRimer(timer: Domain.Rimer, completion: @escaping ((Domain.Rimer) -> Void)) {
        if let data = storage.value(forKey: "Rimers") as? Data {
            guard var rimers = try? PropertyListDecoder().decode([Rimer].self, from: data) else { return }
            for (idx, item) in rimers.enumerated() {
                if item.id != timer.id { return }
                rimers[idx].name = timer.name
                rimers[idx].totalTime = timer.totalTime
                rimers[idx].thumbnail_desc = timer.thumbnail_desc
            }
            storage.set(try? PropertyListEncoder().encode(rimers), forKey: "Rimers")
        }
        
    }
    
    public func deleteRimer(timer: Domain.Rimer, completion: @escaping () -> Void) {
        if let data = storage.value(forKey: "Rimers") as? Data {
            guard var rimers = try? PropertyListDecoder().decode([Rimer].self, from: data) else { return }
            rimers = rimers.filter { $0.id != timer.id }
            storage.set(try? PropertyListEncoder().encode(rimers), forKey: "Rimers")
        }
        rimerList = rimerList.filter { $0.id != timer.id }
    }
}
