//
//  SettingCell.swift
//  Presentation
//
//  Created by root0 on 2022/10/21.
//

import UIKit
import Then
import SnapKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingSwitchOption)
}

struct SettingSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBgColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBgColor: UIColor
    let handler: (() -> Void)
}

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    private let iconContainer = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
    }
    
    private let iconImageView = UIImageView().then {
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
        
    }
    
    private let label = UILabel().then {
        $0.numberOfLines = 1
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let size = contentView.frame.size.height - 12
        iconContainer.snp.makeConstraints {
            $0.width.height.equalTo(contentView.snp.height).offset(-12)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(iconContainer.snp.height).dividedBy(1.5)
            $0.center.equalToSuperview()
        }
//        let imageSize = size / 1.5r
        label.snp.makeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().inset(iconContainer.frame.size.width + 15)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBgColor
        
        if model.title == "아무개와 특별한 대화를 함께하기" {
            let etooRange = (self.label.text! as NSString).range(of: "특별한 대화")
            
            let attributedStr = NSMutableAttributedString(string: label.text!)
            attributedStr.addAttributes([
                .strikethroughStyle: 6,
                .strikethroughColor: UIColor.purple.withAlphaComponent(0.5),
            ], range: etooRange)
            label.attributedText = attributedStr
            
        }
    }
    
    
    
}
