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

public enum RimerAction {
    case grid
    case crud
}

public class RimersViewModel: ViewModelType {
    
    public struct Input {
        // RimerGridView
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
        
        // UpdateRimerView
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let title: Driver<String>
        let rimes: Driver<Double>
        
    }
    
    public struct Output {
        // RimerGridView
        let fetching: Driver<Bool>
        let rimers: Driver<[Rimer]>
        let selectedRimer: Driver<Rimer>
        
        // UpdateRimerView
        let saveEnabled: Driver<Bool>
        let dismiss: Driver<Void>
    }
    
    private var rimersUseCase: RimerRepoInterface
    private let bag = DisposeBag()
    
    private var rimes: [Rimer] = []
    // MARK: - OUTPUT
    //var items: Observable<[RimerListItemModel]> = Observable.just([])
    
    
    // MARK: - Init
//    public init(timerUseCase: RimerUseCase) {
//        self.rimersUseCase = timerUseCase
//    }
    public init(act action: RimerAction = .grid, rimerUseCase: RimerRepoInterface) {
        self.rimersUseCase = rimerUseCase
        
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
            .asDriver() // open UpdateRimerView.swift
        
        return Output(fetching: fetching,
                      rimers: rimers,
                      selectedRimer: selectedRimer
                      ,
                      saveEnabled: .empty(),
                      dismiss: .empty())
    }
    
}

extension RimersViewModel {
    
}

extension RimersViewModel {
    
    // MARK: Old Usecase
    /*
    func viewDidLoad(completion: (([Rimer]) -> Void)? = nil) {
        rimersUseCase.fetch { rimers in
            completion?(rimers)
        }
    }
    
    func didTapSave(rimer: Rimer, completion: (() -> Void)? = nil) {
        rimersUseCase.add(timer: rimer) { _ in
            completion?()
        }
    }
    
    private func appendList(_ rimer: Rimer) {
        rimes = rimes + [rimer]
        items.value = rimes.map(RimerListItemModel.init)
    }
    */
    
    // MARK: INPUT, View Event Methods
    /*
    func viewDidLoad() {
        
    }
    
    func didTapAddBtn() {
        
    }
    
    func didSelectRimer(at index: Int) {
        
    }*/
}
