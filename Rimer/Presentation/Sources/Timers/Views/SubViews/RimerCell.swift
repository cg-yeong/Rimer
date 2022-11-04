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
        $0.contentMode = .scaleAspectFit
    }
    
    private var timerLabel = UILabel().then {
        $0.text = "00 : 00"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private var nameLabel = UILabel().then {
        $0.text = "무슨타이머"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = [UIColor.green, .blue, .systemPink, .purple, .red, .orange, .yellow].randomElement()?.withAlphaComponent(0.5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(image: nil)
    }
    
    func prepare(image: UIImage?) {
        imageView.image = image
    }
    
    func addSubViews() {
        [imageView ,timerLabel, nameLabel].forEach(contentView.addSubview)
    }
    
    func setConstraint() {
        
        imageView.snp.makeConstraints {
            $0.size.equalToSuperview().multipliedBy(0.5)
            $0.center.equalToSuperview()
        }
        
        timerLabel.snp.remakeConstraints {
            $0.center.equalToSuperview()
        }
        
        nameLabel.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timerLabel.snp.bottom).offset(5)
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(5)
        }
    }
    
    func configure(data: JSON) {
        timerLabel.text = data["totalTime"].intValue.toColonTime
        nameLabel.text = data["name"].stringValue
        if data["thumbnail_desc"].stringValue.contains("://") {
            imageView.kf.setImage(with: data["thumbnail_desc"].url)
        } else {
            imageView.image = UIImage(systemName: data["thumbnail_desc"].stringValue)
        }
        
    }
    
}
