//
//  TimersViewModel.swift
//  Presentation
//
//  Created by root0 on 2022/10/20.
//

import Foundation
import RxSwift
import RxCocoa

import Util
import Domain

public protocol RimersViewModelActions {
    func toCreateRimer()
    func toRimer(_ rimer: Rimer)
    func toRimers()
}

public class RimersViewModel: ViewModelType {
    
    public struct Input {
        // RimerGridView
        let trigger: Driver<Void>
        let createTrigger: Driver<Void>
        let selection: Driver<IndexPath>
        
    }
    
    public struct Output {
        // RimerGridView
        let fetching: Driver<Bool>
        let rimers: Driver<[Rimer]>
        let createRimer: Driver<Void>
        let selectedRimer: Driver<Rimer>
        // let error: Driver<Error>
    }
    
    private var rimersUseCase: RimerRepoInterface
    private var actions: RimersViewModelActions
    
    private let bag = DisposeBag()
    
    private var rimes: [Rimer] = []
    // MARK: - OUTPUT
    //var items: Observable<[RimerListItemModel]> = Observable.just([])
    
    
    // MARK: - Init
    public init(rimerUseCase: RimerRepoInterface, actions: RimersViewModelActions) {
        self.rimersUseCase = rimerUseCase
        self.actions = actions
        
    }
    
    
    public func transform(input: Input) -> Output {
        let isFetching = BehaviorRelay(value: false)
        let rimers = input.trigger.flatMapLatest { act in
            return self.rimersUseCase.fetch()
                .asDriver(onErrorJustReturn: [])
        }
        
        let fetching = isFetching.asDriver().distinctUntilChanged().asDriver()
        
        let selectedRimer = input.selection
            .withLatestFrom(rimers) { (indexPath, items) -> Rimer in
                return items[indexPath.row]
            }
            .do(onNext: actions.toRimer)
//            .asDriver() // open UpdateRimerView.swift
        
        let createRimer = input.createTrigger
            .do(onNext: actions.toCreateRimer)
        
        return Output(fetching: fetching,
                      rimers: rimers,
                      createRimer: createRimer,
                      selectedRimer: selectedRimer)
    }
    
}
