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

protocol TimersViewModelInput {
    
}

public class TimersViewModel: ViewModelTypeProtocol {
    
    var validateTimer: BehaviorRelay<Bool> = .init(value: false)
    
    private var timersUseCase: RimerUseCase
    private let bag = DisposeBag()
    
    
    public init(timerUseCase: RimerUseCase) {
        self.timersUseCase = timerUseCase
    }
    
    func viewDidLoad(completion: (([Rimer]) -> Void)? = nil) {
        timersUseCase.fetch { rimers in
            completion?(rimers)
        }
    }
    
    func didTapSave(rimer: Rimer, completion: (() -> Void)? = nil) {
        timersUseCase.add(timer: rimer) { _ in
            completion?()
        }
    }
    
}
