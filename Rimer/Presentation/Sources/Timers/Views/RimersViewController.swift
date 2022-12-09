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
    /// rimerGridView
    var updateRimerView: UpdateRimerView?
    
    let dBag = DisposeBag()
    private var viewModel: RimersViewModel!
    
    // MARK: - Lifecycle
    public static func create(with viewModel: RimersViewModel) -> RimersViewController {
        let vc = RimersViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setRimerGridView()
        commonInit()
//        viewModel.viewDidLoad() { rimerList in
//
//            var snap = self.rimerGridView.dataSource.snapshot()
//            snap.deleteItems(self.rimerGridView.rimerList)
//            self.rimerGridView.rimerList = rimerList
//            snap.appendItems(self.rimerGridView.rimerList)
//            self.rimerGridView.dataSource.apply(snap)
//        }
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
//        [addRimerButton].forEach(view.addSubview)
        view.addSubview(addRimerButton)
    }
    
    func setConstraint() {
        addRimerButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func bind() { // bindViewModel()
        
        
        addRimerButton.rx.tap
            .filter { _ in !self.rimerGridView.gridView.isDragging }
            .bind { [weak self] _ in
                print("\(#file.fileName) :: \(#function) - addRimerBtn Click")
                guard let self = self else { return }
                let view = UpdateRimerView(frame: self.view.frame)
                view.viewModel = self.viewModel
                view.removeViewListener = {
                    self.updateRimerView = nil
                    /*
                    self.viewModel.viewDidLoad() { asd in
                        var snap = self.rimerGridView.dataSource.snapshot()
                        snap.deleteItems(self.rimerGridView.rimerList)
                        self.rimerGridView.rimerList = asd
                        snap.appendItems(self.rimerGridView.rimerList)
                        self.rimerGridView.dataSource.apply(snap)
                    }*/
                }
                self.view.addSubview(view)
                self.updateRimerView = view
                self.updateRimerView!.snp.makeConstraints { make in
                    let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 50
                    make.bottom.equalToSuperview().inset(tabBarHeight)
                    make.leading.trailing.equalToSuperview()
                    make.top.equalToSuperview().inset(self.view.safeAreaInsets)
                }
            }
            .disposed(by: dBag)
        
    }
    
    private func setRimerGridView() {
        self.rimerGridView = RimerGridView()
        rimerGridView.viewModel = viewModel
        view.addSubview(rimerGridView)
        
        rimerGridView.snp.makeConstraints {
            let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 50
            $0.top.equalTo(addRimerButton.snp.bottom)
            $0.bottom.equalToSuperview().inset(tabBarHeight)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}

// MARK: Modern CollectionView
//extension RimersViewController {
//
//    func setUpLayout() {
//        rimersCollectionView.collectionViewLayout = gridFlowLayout.createGridLayout()
//    }
//
//    func setUpDataSource() {
//        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.rimersCollectionView) { collectionView, indexPath, rimer -> UICollectionViewCell? in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RimerCell.id, for: indexPath) as? RimerCell else { preconditionFailure() }
//            var rimerJSON = JSON()
//            rimerJSON["id"] = JSON(rimer.id.uuidString)
//            rimerJSON["name"] = JSON(rimer.name)
//            rimerJSON["totalTime"] = JSON(rimer.totalTime)
//            rimerJSON["thumbnail_desc"] = JSON(rimer.thumbnail_desc)
//
//            cell.configure(data: rimerJSON)
//            return cell
//        }
//        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in }
//    }
//
//    func updateDiffableSnapShot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Rimer>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(rimerList)
//        self.dataSource.apply(snapshot, animatingDifferences: true)
//
//    }
//
//}

