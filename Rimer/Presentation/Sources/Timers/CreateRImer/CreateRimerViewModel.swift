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

class CreateRimerViewModel: ViewModelType {
    
    
    struct Input {
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let title: Driver<String>
        let rimes: Driver<Double>
    }
    
    struct Output {
        let saveEnabled: Driver<Bool>
        let dismiss: Driver<Void>
    }
    
    private var rimersUseCase: RimerRepoInterface
    private let bag = DisposeBag()
    
    public init(act action: RimerAction = .crud, rimerUseCase: RimerRepoInterface) {
        self.rimersUseCase = rimerUseCase
    }
    
    func transform(input: Input) -> Output {
        
        return Output(saveEnabled: Driver.empty(), dismiss: Driver.empty())
    }
}
