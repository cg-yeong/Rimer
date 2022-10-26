//
//  GridCollectionView.swift
//  Presentation
//
//  Created by root0 on 2022/10/21.
//

import UIKit

class GridCollecitonViewFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns = 1
    var cellSpacing = 0.0 {
        didSet {
            self.minimumLineSpacing = self.cellSpacing
            self.minimumInteritemSpacing = self.cellSpacing
        }
    }
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
    }
    convenience init(col: Int, spacing: CGFloat) {
        self.init()
        self.numberOfColumns = col
        self.cellSpacing = spacing
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    private let minColumnWidth: CGFloat = UIScreen.main.bounds.width / 3
    private var cellHeight: CGFloat {
        return minColumnWidth
    }
    
    private var deletingIndexPaths = [IndexPath]()
    private var insertingIndexPaths = [IndexPath]()
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        
        itemSize = CGSize(width: cellWidth, height: cellHeight)
        sectionInset = UIEdgeInsets(top: minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
        sectionInsetReference = .fromSafeArea
    }
    
    // item 변경 되기 직전에 호출 삭제 삽입
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare()
        
        for update in updateItems {
            switch update.updateAction {
            case .delete:
                // indexPath에 해당하는 item이 삭제되기 전에 deletingIndexPaths에 삽입
                guard let indexPath = update.indexPathBeforeUpdate else { return }
                deletingIndexPaths.append(indexPath)
            case .insert:
                guard let indexPath = update.indexPathAfterUpdate else { return }
                insertingIndexPaths.append(indexPath)
            default:
                break
            }
        }
    }
    
    // 삭제 삽입 애니메이션 설정
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else { return nil }
        
        if deletingIndexPaths.contains(itemIndexPath) {
            attributes.transform = .init(scaleX: 0.5, y: 0.5)
            attributes.alpha = 0.0
            attributes.zIndex = 0
        }
        
        return attributes
    }
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else { return nil }
        
        if insertingIndexPaths.contains(itemIndexPath) {
            attributes.transform = .init(scaleX: 1.5, y: 1.5)
            attributes.alpha = 0.0
            attributes.zIndex = 0
        }
        
        /// nil 반환 시 애니메이션의 start point 와 end point 모두 동일한 attriubtes 사용
        return attributes
    }
    
    // performBatchUpdates(:completion:) 호출에서 completion 시작되기 바로 직전에 호출
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
    }
}

enum CollectionViewUpdateState<T> {
    case delete(Int)
    case insert(T, Int)
    case move(Int, Int)
    case reload(Int)
}

class GridCollectionView: UICollectionView {
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
