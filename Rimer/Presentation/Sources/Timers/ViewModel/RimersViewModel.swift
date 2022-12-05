//
//  TimersViewModel.swift
//  Presentation
//
//  Created by root0 on 2022/10/20.
//

import Foundation
import Util
import Domain
import RxSwift
import RxCocoa

protocol RimersViewModelInput {
    func viewDidLoad()
    func didTapAddBtn()
    func didSelectRimer(at index: Int)
}

protocol RimersViewModelOutput {
    var items: Observable<RimerList> { get }
}

protocol RimerGridViewModel: RimersViewModelInput, RimersViewModelOutput {}

public class RimersViewModel: RimerGridViewModel {
    
    
    
    var validateTimer: BehaviorRelay<Bool> = .init(value: false)
    
    private var rimersUseCase: RimerUseCase
    
    private let bag = DisposeBag()
    
    // MARK: - OUTPUT
    public var items: Observable<RimerList> = Observable<RimerList>.just(RimerList(rimers: []))
    
    
    public init(timerUseCase: RimerUseCase) {
        self.rimersUseCase = timerUseCase
    }
    
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
    
}

// MARK: INPUT, View Event Methods
extension RimersViewModel {
    func viewDidLoad() {
        
    }
    
    func didTapAddBtn() {
        
    }
    
    func didSelectRimer(at index: Int) {
        
    }
}
