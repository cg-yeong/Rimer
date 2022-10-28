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

protocol TimersViewModelInput {
    
}

public class TimersViewModel: ViewModelTypeProtocol {
    
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
    
    
    
}
