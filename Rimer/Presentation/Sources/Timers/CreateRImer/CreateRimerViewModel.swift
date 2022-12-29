//
//  CreateRimerViewModel.swift
//  Presentation
//
//  Created by root0 on 2022/12/13.
//

import Foundation
import RxSwift
import RxCocoa
import Domain
import Util

public protocol CreateViewModelAction {
    func toRimers()
}

public class CreateRimerViewModel: ViewModelType {
    
    public struct Input {
        let cancelTrigger: Driver<Void>
        let title: Driver<String>
        let rimes: Driver<Double>
        let saveTrigger: Driver<Void>
    }
    
    public struct Output {
        let saveEnabled: Driver<Bool>
        let dismiss: Driver<Void>
    }
    
    private var rimersUseCase: RimerRepoInterface
    private let action: CreateViewModelAction
    private let bag = DisposeBag()
    
    public init(rimerUseCase: RimerRepoInterface, action: CreateViewModelAction) {
        self.rimersUseCase = rimerUseCase
        self.action = action
    }
    
    public func transform(input: Input) -> Output {
        let titleAndTime = Driver.combineLatest(input.title, input.rimes)
        let canSave = Driver.combineLatest(input.title, input.rimes) { !$0.isEmpty && $1 > 0 }
        
        let save = input.saveTrigger.withLatestFrom(titleAndTime)
            .map { (title, time) in
                return Rimer(name: title, totalTime: time, thumbnail_desc: "")
            }
            .flatMapLatest { [weak self] ele in
                guard let self = self else { return }
                return self.rimersUseCase.save(rimer: ele)
                    .asDriver { error in
                        return Driver.empty()
                    }
            }
        
            
        let dismiss = Driver.merge(input.cancelTrigger)
            .do(onNext: action.toRimers)
        return Output(saveEnabled: canSave, dismiss: dismiss)
    }
}
