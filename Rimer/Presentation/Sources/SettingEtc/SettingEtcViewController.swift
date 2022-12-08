//
//  SettingEtcViewController.swift
//  Presentation
//
//  Created by root0 on 2022/10/18.
//

import UIKit
import Util
import RxSwift
import RxCocoa
import SnapKit
import Then

public class SettingEtcViewController: UIViewController {
    
    var coordinator: SettingsDelegate?
    
    let dBag = DisposeBag()
    private var viewModel: ViewModelTypeProtocol!
    
    var settingsTable = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    var models = [Section]()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setDelegate()
        addSubViews()
        setComponentConstraint()
    }
    
    public init(dependency viewModel: ViewModelTypeProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate() {
        settingsTable.delegate = self
        settingsTable.dataSource = self
    }
    
    func addSubViews() {
        view.addSubview(settingsTable)
    }
    
    func setComponentConstraint() {
        
        settingsTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}


extension SettingEtcViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configure() {
        models.append(
            Section(title: "General",
                    options: [
                        .staticCell(
                            model: SettingsOption(
                                title: "Item",
                                icon: UIImage(systemName: "house"),
                                iconBgColor: .systemPink,
                                handler: {
                                    print("TAP Cell")
                                }
                            )
                        ),
                        .staticCell(
                            model: SettingsOption(
                                title: "Item 2",
                                icon: UIImage(systemName: "house.fill"),
                                iconBgColor: .systemPink,
                                handler: {
                                    print("TAP Cell")
                                }
                            )
                        )
                    ])
        )
        models.append(
            Section(title: "Information",
                    options: [
                        .staticCell(model:
                                        SettingsOption(
                                            title: "Info 1",
                                            icon: UIImage(systemName: "house"),
                                            iconBgColor: .purple,
                                            handler: {
                                                print("TAP Cell")
                                            }
                                        )
                                   ),
                        .staticCell(model:
                                        SettingsOption(
                                            title: "Info 2",
                                            icon: UIImage(systemName: "house"),
                                            iconBgColor: .purple,
                                            handler: {
                                                print("TAP Cell")
                                            }
                                        )
                                   ),
                        .staticCell(model:
                                        SettingsOption(
                                            title: "Info 3",
                                            icon: UIImage(systemName: "house"),
                                            iconBgColor: .purple,
                                            handler: {
                                                print("TAP Cell")
                                            }
                                        )
                                   )
                    ])
        )
        models.append(
            Section(title: "Others",
                    options: [
                        .staticCell(model:
                                        SettingsOption(
                                            title: "Wifi",
                                            icon: UIImage(systemName: "house"),
                                            iconBgColor: .systemGreen,
                                            handler: {
                                                print("TAP Cell")
                                            }
                                        )
                                   ),
                        .staticCell(model:
                                        SettingsOption(
                                            title: "아무개와 특별한 대화를 함께하기",
                                            icon: UIImage(systemName: "house"),
                                            iconBgColor: .systemGreen,
                                            handler: {
                                                print("TAP Cell")
                                            }
                                        )
                                   )
                    ])
        )
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
            
        case .switchCell(let model):
            return UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(var model):
            model.isOn.toggle()
            model.handler()
        }
    }
    
    
}
