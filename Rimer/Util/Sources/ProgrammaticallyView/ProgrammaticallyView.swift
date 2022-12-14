//
//  ProgrammaticallyView.swift
//  Util
//
//  Created by chuchu on 2022/09/16.
//

import UIKit
import RxSwift

open class ProgrammaticallyView: UIView, Programmaticable {
    
    public var removeViewListener : (() -> Void)? = nil
    
    public var fileName: String = "" {
        willSet {
            print("\(newValue) init")
        }
    }
    
    public let disposeBag = DisposeBag()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addComponent()
        setConstraints()
        bind()
        moreAction()
    }
    
    open func addComponent() { }
    
    open func setConstraints() { }
    
    open func bind() { }
    
    open func moreAction() { }
    
    open func deinitAction() { }
    
    deinit {
        print("\(fileName) deinit")
        deinitAction()
    }
}
