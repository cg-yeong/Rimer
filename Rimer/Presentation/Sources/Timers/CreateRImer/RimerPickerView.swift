//
//  RimerPickerView.swift
//  Presentation
//
//  Created by root0 on 2022/11/02.
//

import UIKit
import SnapKit
import Then

open class RimerPickerView: UIView {
    private enum Constants {
        static let fontSize: CGFloat = 44
        static let colonFontSize: CGFloat = Constants.fontSize * 0.75
        static let formatFontSize: CGFloat = 24
    }
    public enum TimeFormat: String {
        case hms
        case ms
        
        var components: [TimeComponent] {
            switch self {
            case .hms:
                return [.hour, .minute, .second]
            case .ms:
                return [.minute, .second]
            }
        }
    }
    
    public enum TimeComponent: Int, CaseIterable {
        case hour = 0
        case minute = 1
        case second = 2
    }
    
    // MARK: - Public properties
    
    public var rowHeight: CGFloat = 60.0
    public var timeLabelFont: UIFont?
    public var colonLabelFont: UIFont? {
        didSet {
            colonLabel.font = colonLabelFont
        }
    }
    
    public var showUnitSeparator = true {
        didSet {
            colonLabel.isHidden = !showUnitSeparator
        }
    }
    
    public var onNumberTimePicked: ((_ hour: Int, _ minute: Int, _ second: Int) -> Void)?
    public var onTotalTimeListener: ((_ totalTime: Int) -> Void)?
    
    // MARK: - Private properties
    public var timeFormat: TimeFormat
    private var components: [TimeComponent]
    private var hours: [Int] = Array(0..<23)
    private var minutes: [Int] = Array(0..<60)
    private var seconds: [Int] = Array(0..<60)
    
    private var selectedHour: Int?
    private var selectedMinute: Int?
    private var selectedSecond: Int?
    
    private var hourRows: Int = 24
    private lazy var hourRowsMiddle: Int = (hourRows / hours.count) / 2 * hours.count
    private var minuteRows: Int = 60
    private lazy var minuteRowMiddle: Int = (minuteRows / minutes.count) / 2 * minutes.count
    private var secondRows: Int = 60
    private lazy var secondRowMiddle: Int = (secondRows / seconds.count) / 2 * seconds.count
    
    // MARK: - Views
    public lazy var pickerView = UIPickerView().then {
        $0.transform = CGAffineTransformMakeScale(1, 1)
    }
    
    private lazy var colonLabel = UILabel().then {
        let size = Constants.colonFontSize
        $0.font = .systemFont(ofSize: size, weight: .bold)
        $0.textColor = .white
        $0.text = ":"
    }
    
    
    public init(format: TimeFormat = .ms, tintColor: UIColor = .black) {
        self.timeFormat = format
        self.components = format.components
        super.init(frame: .zero)
        self.tintColor = tintColor
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(timeFormat: TimeFormat) {
        self.timeFormat = timeFormat
        self.components = timeFormat.components
        pickerView.reloadAllComponents()
        layoutSubviews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard !components.isEmpty else { return }
        let offset = (frame.width / CGFloat(components.count)) - 2
        colonLabel.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(offset)
        }
    }
    
    func setupViews() {
        addComponents()
        setConstraints()
    }
    
    func addComponents() {
        addSubview(pickerView)
        
        pickerView.addSubview(colonLabel)
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func setConstraints() {
        pickerView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
        
        colonLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    open func setInitialValue() {
        selectedHour = 0
        
        selectedMinute = 0
        pickerView.selectRow(minuteRowMiddle, inComponent: TimeComponent.minute.rawValue, animated: false)
        selectedSecond = 0
        pickerView.selectRow(minuteRowMiddle, inComponent: TimeComponent.second.rawValue, animated: false)
    }
    
}

extension RimerPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch components[component] {
        case .hour:
            return hourRows
        case .minute:
            return minuteRows
        case .second:
            return secondRows
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = tintColor
        label.font = timeLabelFont ?? .systemFont(ofSize: Constants.fontSize, weight: .semibold)
        switch components[component] {
        case .hour:
            label.text = String(format: "%02d", hours[row % hours.count])
        case .minute:
            label.text = String(format: "%02d", minutes[row % minutes.count])
        case .second:
            label.text = String(format: "%02d", seconds[row % seconds.count])
        }
        
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch components[component] {
        case .hour:
            self.selectedHour = hours[safe: row % hours.count]
        case .minute:
            self.selectedMinute = minutes[safe: row % minutes.count]
        case .second:
            self.selectedSecond = seconds[safe: row % seconds.count]
        }
        // timeformat : hms or ms
        let hour = selectedHour ?? 0
        let minute = selectedMinute ?? 0
        let second = selectedSecond ?? 0
        
        let totalTime = second + (minute * 60) + (hour * 3600)
        onTotalTimeListener?(totalTime)
    }
}
