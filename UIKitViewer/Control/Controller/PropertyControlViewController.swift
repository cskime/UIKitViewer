//
//  OperationViewController.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import SnapKit
import Then

class PropertyControlViewController: UIViewController {
    
    // MARK: Views
    
    private lazy var cellProvider = CellProvider(tableView: tableView).then {
        $0.delegate = self
    }
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.dataSource = self
        $0.delegate = self
    }
    private var displayView: DisplayView!
    
    // MARK: Model
    
    private let controlModel = ControlModel.shared
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Initialize
    
    init(object: UIKitObject) {
        super.init(nibName: nil, bundle: Bundle.main)
        controlModel.setupDataSource(for: object)
        displayView = DisplayView(objectType: object)
    }
    
    deinit {
        controlModel.removeAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupAttributes()
        setupConstraints()
    }
    
    private func setupAttributes() {
        view.backgroundColor = ColorReference.background
        
        guard let targetObject = controlModel.targetObject else { return }
        navigationItem.title = targetObject.rawValue
    }
    
    struct UI {
        static let paddingY: CGFloat = 24
        static let paddingX: CGFloat = 48
    }
    private func setupConstraints() {
        let subviews = [displayView!, tableView]
        subviews.forEach { view.addSubview($0) }
        
        let guide = view.safeAreaLayoutGuide
        displayView.snp.makeConstraints {
            $0.top.equalTo(guide).offset(UI.paddingY)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(UI.paddingX)
            $0.height.equalTo(guide).multipliedBy(0.3)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(displayView.snp.bottom).offset(UI.paddingY)
            $0.leading.trailing.bottom.equalTo(guide)
        }
    }
}

// MARK:- UITableViewDataSource

extension PropertyControlViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return controlModel.objects.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return controlModel.objects[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controlModel.objects[section].properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = controlModel.objects[indexPath.section]
        let cell = cellProvider.createCell(with: object, for: indexPath)
        return cell
    }
}

// MARK:- UITableViewDelegate

extension PropertyControlViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return tableView.cellForRow(at: indexPath) is MethodCell ? indexPath : nil
    }
}

// MARK:- ControlCellDelegate

extension PropertyControlViewController: ControlCellDelegate {
    
    func cell(_ tableViewCell: UITableViewCell, valueForColor color: UIColor?) {
        guard let cell = tableViewCell as? PaletteCell else { return }
        displayView.configure(color: color,
                                   for: cell.currentProperty.name,
                                   of: cell.currentObject)
    }
    
    func cell(_ tableViewCell: UITableViewCell, valueForToggle value: Bool) {
        guard let cell = tableViewCell as? ToggleCell else { return }
        displayView.configure(isOn: value,
                                   for: cell.currentProperty.name,
                                   of: cell.currentObject)
    }
    
    func cell(_ tableViewCell: UITableViewCell, valueForSlider value: Float) {
        guard let cell = tableViewCell as? SliderCell else { return }
        displayView.configure(value: value,
                                   for: cell.currentProperty.name,
                                   of: cell.currentObject)
    }
    
    func cell(_ tableViewCell: UITableViewCell, valueForTextField text: String) {
        guard let cell = tableViewCell as? TextCell else { return }
        displayView.configure(text: text,
                                   for: cell.currentProperty.name,
                                   of: cell.currentObject)
    }
    
    func cell(_ tableViewCell: UITableViewCell, valueForStepper value: Double) {
        guard let cell = tableViewCell as? StepperCell else { return }
        displayView.configure(value: value,
                                   for: cell.currentProperty.name,
                                   of: cell.currentObject)
    }
    
    func cell(_ tableViewCell: UITableViewCell, valuesForSelect values: [String]) {
        guard let cell = tableViewCell as? SelectCell else { return }
        presentActionSheet(values: values) { (rawValue, selected) in
            cell.updateSelectedValue(selected)
            self.displayView.configure(rawValue: rawValue,
                                       for: cell.currentProperty.name,
                                       of: cell.currentObject)
        }
    }
    
    private func presentActionSheet(values: [String], actionHandler: @escaping (Int, String) -> ()) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        var actions = [UIAlertAction]()
        values
            .enumerated()
            .forEach { (index, title) in
                let action = UIAlertAction(title: title, style: .default) { _ in
                    actionHandler(index, title)
                }
                actions.append(action)
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actions.append(cancelAction)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    
    func cellWillCallMethod(_ tableViewCell: UITableViewCell) {
        guard let cell = tableViewCell as? MethodCell else { return }
        displayView.callMethod(method: cell.currentProperty.name,
                                    of: cell.currentObject)
    }
}
