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

protocol RimersViewModelInput {
    func viewDidLoad()
    func didTapAddBtn()
    func didSelectRimer(at index: Int)
}

protocol RimersViewModelOutput {  }
protocol RimerGridViewModel: RimersViewModelInput, RimersViewModelOutput {}

public class RimersViewModel: ViewModelType {
    
    public struct Input {
        // RimersViewController
        let createRimerTrigger: Driver<Void>
        
        // RimerGridView
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
        
    }
    
    public struct Output {
        let fetching: Driver<Bool>
        let rimers: Driver<[RimerItemViewModel]>
        let selectedRimer: Driver<Rimer>    }
    
    private var rimersUseCase: RimerRepoInterface
    private let bag = DisposeBag()
    
    private var rimes: [Rimer] = []
    // MARK: - OUTPUT
    //var items: Observable<[RimerListItemModel]> = Observable.just([])
    
    
    // MARK: - Init
//    public init(timerUseCase: RimerUseCase) {
//        self.rimersUseCase = timerUseCase
//    }
    public init(rimerUseCase: RimerRepoInterface) {
        self.rimersUseCase = rimerUseCase
        
    }
    
    
    public func transform(input: Input) -> Output {
        
        let rimers = input.trigger.flatMapLatest { act in
            return self.rimersUseCase.fetch()
                //.trackActivity
                //.trackError
                .asDriver(onErrorJustReturn: [])
                .map { $0.map { RimerItemViewModel(with: $0) } }
        }
        
        return Output(fetching: <#T##Driver<Bool>#>,
                      rimers: rimers,
                      selectedRimer: <#T##Driver<Rimer>#>)
    }
    
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
