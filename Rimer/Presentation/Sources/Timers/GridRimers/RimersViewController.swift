//
//  TimersViewController.swift
//  Presentation
//
//  Created by root0 on 2022/10/18.
//

import UIKit
import RxCocoa
import RxSwift
import Util
import Then
import SnapKit
//import Domain
import SwiftyJSON

public class RimersViewController: UIViewController {
    
    var coordinator: RimersCoordinator?
    
    var rimerGridView: RimerGridView!
    var addRimerBtn: UIBarButtonItem?
    let addRimerButton = UIButton().then { btn in
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    
    let dBag = DisposeBag()
    private var viewModel: RimersViewModel!
    
    // MARK: - Lifecycle
    public static func create(with viewModel: RimersViewModel) -> RimersViewController {
        let vc = RimersViewController()
        vc.viewModel = viewModel
        vc.rimerGridView = RimerGridView.init()
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func commonInit() {
        addComponent()
        setConstraint()
        bind()
    }
    
    func addComponent() {
        view.addSubview(addRimerButton)
        view.addSubview(rimerGridView)
    }
    
    func setConstraint() {
        addRimerButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        rimerGridView.snp.makeConstraints {
            let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 50
            $0.top.equalTo(addRimerButton.snp.bottom)
            $0.bottom.equalToSuperview().inset(tabBarHeight)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func bind() { // bindViewModel()
        
//        addRimerButton.rx.tap
//            .filter { _ in !self.rimerGridView.gridView.isDragging }
//            .bind { [weak self] _ in
//                print("\(#file.fileName) :: \(#function) - addRimerBtn Click")
//                guard let self = self else { return }
//                self.coordinator?.crudStart()
//            }
//            .disposed(by: dBag)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in }
            .asDriver(onErrorRecover: { error in .empty() })
        
        
        let input = RimersViewModel.Input(trigger: viewWillAppear,
                                          createTrigger: addRimerButton.rx.tap.asDriver(),
                                          selection: rimerGridView.gridView.rx.itemSelected.asDriver())
        
        
        let output = viewModel.transform(input: input)
        output.rimers.drive { [weak self] rimers in
            guard let self = self else { return }
            var snap = self.rimerGridView.dataSource.snapshot()
            snap.deleteItems(self.rimerGridView.rimerList)
            self.rimerGridView.rimerList = rimers
            snap.appendItems(rimers)
            self.rimerGridView.dataSource.apply(snap)
        }.disposed(by: dBag)
        
//        output.fetching
        
        output.createRimer
            .drive() // viewModel's action : Coordinator -> open CreateRimerVC
            .disposed(by: dBag)
        
        output.selectedRimer
            .drive()
            .disposed(by: dBag)
        
    }
    
}
