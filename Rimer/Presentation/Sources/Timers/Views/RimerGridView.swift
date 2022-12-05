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

import Util
import Domain

class RimerGridView: ProgrammaticallyView {
    
    enum Section: CaseIterable {
        case main
    }
    
    lazy var gridView = UICollectionView(frame: .zero, collectionViewLayout: GridCollecitonViewFlowLayout()).then { grid in
        grid.isScrollEnabled = true
        grid.clipsToBounds = true
        grid.register(RimerCell.self, forCellWithReuseIdentifier: RimerCell.id)
        grid.isDirectionalLockEnabled = true
        grid.collectionViewLayout = GridCollecitonViewFlowLayout().createGridLayout()
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Rimer>!
//    var rimerList: [Rimer] = []
    var rimerList: RimerList = RimerList(rimers: [])
    
    override func addComponent() {
        fileName = #file.fileName
        [gridView].forEach(addSubview)
    }
    
    override func setConstraints() {
        gridView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupGridLayout() {
        gridView.collectionViewLayout = GridCollecitonViewFlowLayout().createGridLayout()
    }
    
    func setupDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.gridView) { collectionview, indexPath, rimer -> UICollectionViewCell? in
            
            guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: RimerCell.id, for: indexPath) as? RimerCell else {
                preconditionFailure()
            }
            var rimerJSON = JSON()
            rimerJSON["id"] = JSON(rimer.id.uuidString)
            rimerJSON["name"] = JSON(rimer.name)
            rimerJSON["totalTIme"] = JSON(rimer.totalTime)
            rimerJSON["thumbnail_desc"] = JSON(rimer.thumbnail_desc)
            
            cell.configure(data: rimerJSON)
            return cell
            
        }
    }
    
    func updateDiffableSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Rimer>()
        snapshot.appendSections([.main])
        snapshot.reloadItems(rimerList.rimers)
        self.dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
}
