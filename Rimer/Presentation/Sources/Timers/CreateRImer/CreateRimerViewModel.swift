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

public class CreateRimerViewModel: ViewModelType {
    
    public struct Input {
        let cancelTrigger: Driver<Void>
        let saveTrigger: Driver<Void>
        let title: Driver<String>
        let rimes: Driver<Double>
    }
    
    public struct Output {
        let saveEnabled: Driver<Bool>
        let dismiss: Driver<Void>
    }
    
    private var rimersUseCase: RimerRepoInterface
    private let bag = DisposeBag()
    
    public init(rimerUseCase: RimerRepoInterface) {
        self.rimersUseCase = rimerUseCase
    }
    
    public func transform(input: Input) -> Output {
        
        return Output(saveEnabled: Driver.empty(), dismiss: Driver.empty())
    }
}
