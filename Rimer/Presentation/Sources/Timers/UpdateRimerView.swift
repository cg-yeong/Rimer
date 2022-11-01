//
//  UpdateRimerView.swift
//  Presentation
//
//  Created by root0 on 2022/10/31.
//

import UIKit
import RxSwift
import SnapKit
import Then
import Util

class UpdateRimerView: ProgrammaticallyView {
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    let contentView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    override func addComponent() {
        fileName = #file.fileName
        [backgroundView, contentView].forEach(addSubview(_:))
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(100)
        }
    }
    
    override func bind() {
        
    }

}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UpdateRimerViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = UpdateRimerView(frame: .zero)
            return view
        }
    }
}
#endif
class MyBaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BorderedButton_Preview: PreviewProvider {
    static var previews: some View {
                // 이런식으로 사용합니다‼️
        UIViewPreview {
            let button = MyBaseButton(frame: .zero)
            button.setTitle("Folloddw", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            return button

        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif
