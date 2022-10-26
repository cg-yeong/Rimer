//
//  RimerCell.swift
//  Presentation
//
//  Created by root0 on 2022/10/25.
//

import UIKit
import Then
import SnapKit
import SwiftyJSON
import Kingfisher

final class RimerCell: UICollectionViewCell {
    
    static let id = "RimerCell"
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private var timerLabel = UILabel().then {
        $0.text = "00 : 00"
        $0.textColor = .white
    }
    
    private var nameLabel = UILabel().then {
        $0.text = "무슨타이머"
        $0.textColor = .white
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(image: nil)
    }
    
    func prepare(image: UIImage?) {
        imageView.image = image
    }
    
    func addSubViews() {
        contentView.addSubview(imageView)
        [timerLabel, nameLabel].forEach(imageView.addSubview(_:))
    }
    
    func setConstraint() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        timerLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        nameLabel.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.greaterThanOrEqualTo(timerLabel.snp.bottom).offset(5)
        }
    }
    
    func configure(data: JSON) {
        timerLabel.text = data["totalTime"].stringValue
        nameLabel.text = data["name"].stringValue
        imageView.kf.setImage(with: data["thumbnail_desc"].url)
    }
    
}
