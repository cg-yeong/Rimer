//
//  RimerGridView.swift
//  Presentation
//
//  Created by root0 on 2022/12/05.
//

import Foundation
import UIKit
import Then
import SnapKit
import SwiftyJSON
import RxSwift
import RxCocoa

import Util
import Domain

class RimerGridView: ProgrammaticallyView {
    
    enum Section: CaseIterable {
        case main
    }
    
    lazy var gridView = UICollectionView(frame: .zero, collectionViewLayout: GridCollecitonViewFlowLayout()).then { grid in
        grid.backgroundColor = .white
        grid.isScrollEnabled = true
        grid.clipsToBounds = true
        grid.register(RimerCell.self, forCellWithReuseIdentifier: RimerCell.id)
        grid.isDirectionalLockEnabled = true
        grid.collectionViewLayout = GridCollecitonViewFlowLayout().createGridLayout()
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Rimer>!
    
    var viewModel: RimersViewModel!
    var rimerList: [Rimer] = []
//    var rimerList: RimerList = RimerList(rimers: [])
    
    override func addComponent() {
        fileName = #file.fileName
        [gridView].forEach(addSubview)
        
    }
    
    override func setConstraints() {
        gridView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        setupDataSource()
        updateDiffableSnapShot()
        bindViewModel()
    }
    
    func setupGridLayout() {
        gridView.collectionViewLayout = GridCollecitonViewFlowLayout().createGridLayout()
    }
    
    func setupDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.gridView) { collectionview, indexPath, rimer -> UICollectionViewCell? in
            //collectionview.dequeueConfiguredReusableCell(using: <#T##UICollectionView.CellRegistration<Cell, Item>#>, for: <#T##IndexPath#>, item: <#T##Item?#>)
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: RimerCell.id, for: indexPath) as? RimerCell else {
                preconditionFailure()
            }
            /*
            var rimerJSON = JSON()
            rimerJSON["id"] = JSON(rimer.id.uuidString)
            rimerJSON["name"] = JSON(rimer.name)
            rimerJSON["totalTIme"] = JSON(rimer.totalTime)
            rimerJSON["thumbnail_desc"] = JSON(rimer.thumbnail_desc)
            
            cell.configure(data: rimerJSON)
             */
            cell.configData(with: rimer)
            return cell
            
        }
    }
    
    func updateDiffableSnapShot() {
        //var snapshot = NSDiffableDataSourceSnapshot<Section, Rimer>()
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.main])
        snapshot.reloadItems(rimerList)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    func reload() {
        
        var snap = dataSource.snapshot()
        snap.deleteItems(rimerList)
        // viewmodel.output.fetch etc
        snap.appendItems(rimerList, toSection: .main)
        dataSource.apply(snap)
    }
    
    func bindViewModel() {
        assert(viewModel != nil)
        let layoutSubviews = self.rx.sentMessage(#selector(UIView.layoutSubviews))
            .map { _ in }
            .asDriver(onErrorDriveWith: .empty())
        
        let pull = gridView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        let selection = gridView.rx.itemSelected.asDriver()
        
        let input = RimersViewModel.Input(trigger: Driver.merge(layoutSubviews, pull),
                                          selection: selection)
        let output = viewModel.transform(input: input)
        
        //output
        output.fetching
            .drive(gridView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        output.rimers
            .drive { items in
                var snap = self.dataSource.snapshot()
                snap.deleteItems(self.rimerList)
                snap.appendItems(items)
                self.rimerList = items
                self.dataSource.apply(snap)
            }
            .disposed(by: disposeBag)
        
        output.selectedRimer
            .drive()
            .disposed(by: disposeBag)
    }
    
    func updateRimer(_ rimer: Rimer) {
        let view = UpdateRimerView(frame: self.frame)
        view.viewModel = self.viewModel
        
        self.addSubview(view)
        view.snp.makeConstraints { make in
            let bottom = self.safeAreaInsets.bottom
            make.bottom.equalToSuperview().inset(bottom)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(self.safeAreaInsets)
        }
    }
}
