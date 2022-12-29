//
//  CRUDRimerVC.swift
//  Presentation
//
//  Created by root0 on 2022/12/28.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

import Util

public class CRUDRimerVC: ProgrammaticallyViewController, UITextFieldDelegate {
    
    var coordinator: RimersCoordinator?
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let contentView = UIView().then {
        $0.snp.setLabel("contentView")
        $0.backgroundColor = UIColor(red: 129, green: 129, blue: 129, alpha: 1)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    lazy var nameField = UITextField().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.placeholder = "이름을 설정해주세요."
        $0.returnKeyType = .done
        $0.addLeftPaddingView(left: 4)
        $0.delegate = self
    }
    
    let timerLabel = UILabel().then {
        $0.text = "시간"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    let timerPickView = RimerPickerView().then {
        $0.snp.setLabel("timerPickView")
        $0.timeFormat = .hms
        $0.showUnitSeparator = true
        $0.tintColor = .white
        $0.rowHeight = 40
        $0.timeLabelFont = .systemFont(ofSize: 32, weight: .semibold)
        $0.colonLabelFont = .systemFont(ofSize: 32 * 0.75, weight: .bold)
        
        $0.backgroundColor = .systemPink.withAlphaComponent(0.9)
        $0.layer.cornerRadius = 24
    }
    
    let imgLabel = UILabel().then {
        $0.text = "이미지"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    let imgContainerView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = .lightGray.withAlphaComponent(0.5)
        $0.clipsToBounds = true
    }
    
    let addImageBtn = UIButton().then {
        let img = UIImage(systemName: "plus")
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .lightGray
        $0.setImage(img, for: .normal)
    }
    
    let imgView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = nil//UIImage(systemName: "book")
        $0.isHidden = $0.image == nil ? true : false
        $0.layer.cornerRadius = 16
    }
    
    let completeBtn = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitle("완료", for: .disabled)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.isEnabled = false
    }
    
    let cancelBtn = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    private var viewModel: CreateRimerViewModel!
    
    private let ots = BehaviorRelay<Double>(value: 0.0)
    
    var tempTime: Double = 0.0
    
    public static func create(with viewModel: CreateRimerViewModel) -> CRUDRimerVC {
        let vc = CRUDRimerVC()
        vc.viewModel = viewModel
        return vc
    }
    
//    moreAction()
    override public func addComponent() {
        fileName = "CRUDRimerVC"
        [ backgroundView, contentView ].forEach(view.addSubview)
        [ nameLabel, nameField, timerLabel, timerPickView, imgLabel, imgContainerView, completeBtn, cancelBtn ].forEach(contentView.addSubview(_:))
        [ addImageBtn, imgView ].forEach(imgContainerView.addSubview(_:))
    }
    
    override public func setConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
        }
        
        nameLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(25)
        }
        
        nameField.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
        
        timerLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(nameField.snp.bottom).offset(8)
        }
        
        timerPickView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(timerLabel.snp.bottom).offset(4)
            $0.height.equalTo(150)
        }
        
        imgLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(timerPickView.snp.bottom).offset(8)
        }
        
        imgContainerView.snp.remakeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(imgLabel.snp.bottom).offset(4)
            $0.width.height.equalTo(100)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        addImageBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        imgView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        completeBtn.snp.remakeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(completeBtn.titleLabel!.snp.size).multipliedBy(2.3)
            $0.bottom.equalTo(imgContainerView.snp.bottom)
        }
        
        cancelBtn.snp.remakeConstraints {
            $0.trailing.equalTo(completeBtn.snp.leading).offset(-8)
            $0.bottom.equalTo(imgContainerView.snp.bottom)
            $0.size.equalTo(cancelBtn.titleLabel!.snp.size).multipliedBy(2.3)
        }
    }
    
    override public func bind() {
        
        timerPickView.onTotalTimeListener = { [weak self] timeSeconds in
            print("시간초 : \(timeSeconds)")
            self?.tempTime = Double(timeSeconds)
            self?.ots.accept(Double(timeSeconds))
        }
        
        let input = CreateRimerViewModel.Input(cancelTrigger: cancelBtn.rx.tap.asDriver(),
                                               title: nameField.rx.text.orEmpty.asDriver(),
                                               rimes: ots.asDriver(),
                                               saveTrigger: completeBtn.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.dismiss
            .drive()
            .disposed(by: disposeBag)
        
        output.saveEnabled
            .drive(completeBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.endEditing(true)
    }
    
}

extension CRUDRimerVC {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
