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

public class TimersViewController: UIViewController {
    
    var coordi: TimersDelegate?
    
    private var viewModel: TimersViewModel!
    let dBag = DisposeBag()
    
    private var gridFlowLayout = GridCollecitonViewFlowLayout().then {
        $0.cellSpacing = 8
        $0.numberOfColumns = 1
    }
    
    private var rimersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: GridCollecitonViewFlowLayout(col: 2, spacing: 8)).then {
        $0.isScrollEnabled = true
        $0.contentInset = .init(top: 4, left: 8, bottom: 4, right: 8)
        $0.clipsToBounds = true
        $0.register(RimerCell.self, forCellWithReuseIdentifier: RimerCell.id)
    }
    
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Rimer>!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        attachSubViews()
        setConstraint()
        
        viewModel.viewDidLoad { rimers in
            // datasource reload
            self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.rimersCollectionView) { collectionView, indexPath, rimer -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RimerCell.id, for: indexPath) as? RimerCell else { preconditionFailure() }
//                cell
                return cell
            }
        }
        
        bind()
    }
    
    func attachSubViews() {
        view.addSubview(rimersCollectionView)
    }
    
    func setConstraint() {
        rimersCollectionView.snp.remakeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(120)
        }
    }
    
    func bind() {
        
    }
    
    public static func create(with viewModel: TimersViewModel) -> TimersViewController {
        let vc = TimersViewController()
        vc.viewModel = viewModel
        
        return vc
    }
}

extension TimersViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? GridCollecitonViewFlowLayout,
              flowLayout.numberOfColumns > 0
        else { fatalError() }
        
        let widthOfCells = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        let widthOfSpacing = CGFloat(flowLayout.numberOfColumns - 1) * flowLayout.cellSpacing
        
        let width = (widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns)
        return CGSize(width: width, height: width)
        
    }
}
