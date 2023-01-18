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

class RimerGridView: ProgrammaticallyView, UICollectionViewDelegate {
    
    enum Section: CaseIterable {
        case main
    }
    
    lazy var gridView = UICollectionView(frame: .zero, collectionViewLayout: GridCollecitonViewFlowLayout()).then { grid in
        grid.backgroundColor = .systemYellow.withAlphaComponent(0.2)
        grid.isScrollEnabled = true
        grid.clipsToBounds = true
        grid.isDirectionalLockEnabled = true
        grid.delegate = self
        grid.collectionViewLayout = GridCollecitonViewFlowLayout().createGridLayout()
    }
    var rimerCellRegistration: UICollectionView.CellRegistration<RimerCell, Rimer>!
    var dataSource: UICollectionViewDiffableDataSource<Section, Rimer>!
    
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
        setupCellRegistration()
        setupDataSource()
        updateDiffableSnapShot()
    }
    
    func setupGridLayout() {
        gridView.collectionViewLayout = GridCollecitonViewFlowLayout().createGridLayout()
    }
    
    func setupCellRegistration() {
        rimerCellRegistration = .init(handler: { cell, indexPath, rimer in
            cell.configData(with: rimer)
            
        })
    }
    
    func setupDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.gridView) { [weak self] collectionview, indexPath, rimer -> UICollectionViewCell? in
            guard let self = self else { return nil }
            let cell = collectionview.dequeueConfiguredReusableCell(using: self.rimerCellRegistration, for: indexPath, item: rimer)
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
        snap.appendItems(rimerList, toSection: .main)
        dataSource.apply(snap)
    }
    
}
