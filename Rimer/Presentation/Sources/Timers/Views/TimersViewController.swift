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
import Domain
import SwiftyJSON

public class TimersViewController: UIViewController {
    
    var addRimerBtn: UIBarButtonItem?
    
    var updateRimerView: UpdateRimerView?
    var coordi: TimersCoordinator?
    
    private var viewModel: TimersViewModel!
    
    private var gridFlowLayout = GridCollecitonViewFlowLayout()
    private var rimersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: GridCollecitonViewFlowLayout()).then {
        $0.isScrollEnabled = true
        $0.clipsToBounds = true
        $0.register(RimerCell.self, forCellWithReuseIdentifier: RimerCell.id)
//        $0.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
        $0.isDirectionalLockEnabled = true
        
    }
    enum Section: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Rimer>!
    var rimerList: [Rimer] = []
    
    let dBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        attachSubViews()
        setConstraint()
        
        viewModel.viewDidLoad() { rimerList in
            self.rimerList = rimerList
        }
        
        setUpDataSource()
        updateDiffableSnapShot()
        setUpLayout()
        
        bind()
    }
    
    func attachSubViews() {
        view.addSubview(rimersCollectionView)
        
        addRimerBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = addRimerBtn
    }
    
    func setConstraint() {
        
        rimersCollectionView.snp.remakeConstraints {
            $0.leading.trailing.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        if let addRimerBtn = addRimerBtn {
            addRimerBtn.rx.tap
                .withUnretained(self)
                .bind { (owner, _) in
                    guard owner.updateRimerView == nil else { return }
                    let view = UpdateRimerView(frame: owner.view.frame)
                    view.viewModel = owner.viewModel
                    view.removeViewListener = {
                        owner.updateRimerView = nil
                        owner.viewModel.viewDidLoad() { asd in
                            
                            var snap = owner.dataSource.snapshot()
                            snap.deleteItems(owner.rimerList)
                            owner.rimerList = asd
                            snap.appendItems(owner.rimerList)
                            
                            owner.dataSource.apply(snap)
                        }
                    }
                    owner.view.addSubview(view)
                    owner.updateRimerView = view
                    owner.updateRimerView!.snp.makeConstraints {
                        let tabBarHeight = owner.tabBarController?.tabBar.frame.size.height ?? 50
                        $0.bottom.equalToSuperview().inset(tabBarHeight)
                        $0.leading.trailing.equalToSuperview()
                        $0.top.equalToSuperview().inset(owner.view.safeAreaInsets)
                    }
                }
                .disposed(by: dBag)
        }
        
    }
    
    private func setUpdateRimerView() {
    }
    
    public static func create(with viewModel: TimersViewModel) -> TimersViewController {
        let vc = TimersViewController()
        vc.viewModel = viewModel
        
        return vc
    }
}

// MARK: CollectionView Part
extension TimersViewController {
    
    func setUpLayout() {
        rimersCollectionView.collectionViewLayout = gridFlowLayout.createGridLayout()
    }
    
    func setUpDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.rimersCollectionView) { collectionView, indexPath, rimer -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RimerCell.id, for: indexPath) as? RimerCell else { preconditionFailure() }
            var rimerJSON = JSON()
            rimerJSON["id"] = JSON(rimer.id.uuidString)
            rimerJSON["name"] = JSON(rimer.name)
            rimerJSON["totalTime"] = JSON(rimer.totalTime)
            rimerJSON["thumbnail_desc"] = JSON(rimer.thumbnail_desc)
            
            cell.configure(data: rimerJSON)
            return cell
        }
//        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in }
    }
    
    func updateDiffableSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Rimer>()
        snapshot.appendSections([.main])
        snapshot.appendItems(rimerList)
        self.dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
}

