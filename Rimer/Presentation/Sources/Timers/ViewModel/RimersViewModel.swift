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
        
    }
    
    public struct Output {
        
    }
    var validateTimer: BehaviorRelay<Bool> = .init(value: false)
    //private var rimersUseCase: RimerUseCase
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
        
        return Output()
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
