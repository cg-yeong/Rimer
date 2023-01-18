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
    
    let delRimerButton = UIButton().then { btn in
        btn.setImage(UIImage(systemName: "minus.circle"), for: .normal)
    }
    
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
        [addRimerButton, delRimerButton].forEach { view.addSubview($0) }
//        view.addSubview(addRimerButton)
        view.addSubview(rimerGridView)
    }
    
    func setConstraint() {
        addRimerButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        delRimerButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(addRimerButton.snp.leading).offset(-16)
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
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in }
            .asDriver(onErrorRecover: { error in .empty() })
        
        
        let input = RimersViewModel.Input(trigger: viewWillAppear,
                                          createTrigger: addRimerButton.rx.tap.asDriver(),
                                          selection: rimerGridView.gridView.rx.itemSelected.asDriver(),
                                          deleteTrigger: delRimerButton.rx.tap.asDriver())
        
        
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
            .drive { [weak self] rimer in
                guard let self = self else { return }
                var snap = self.rimerGridView.dataSource.snapshot()
            }
            .disposed(by: dBag)
        
        output.deletedRimer
            .drive { [weak self] rimers in
                guard let self = self else { return }
                var snap = self.rimerGridView.dataSource.snapshot()
                self.rimerGridView.dataSource.apply(snap, animatingDifferences: true)
            }
            .disposed(by: dBag)
    }
    
}
