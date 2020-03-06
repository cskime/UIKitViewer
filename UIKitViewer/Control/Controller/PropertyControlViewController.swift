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

  private lazy var cellProvider = CellProvider(tableView: self.tableView).then {
    $0.delegate = self
  }

  private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.dataSource = self
    $0.allowsSelection = false
  }
  private var displayView: DisplayView!

  // MARK: Model

  private let controlModel = ControlModel.shared

  // MARK: Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }

  // MARK: Initialize

  init(object: UIKitObject) {
    super.init(nibName: nil, bundle: Bundle.main)
    self.controlModel.setupDataSource(for: object)
    self.displayView = DisplayView(objectType: object)
  }
  
  deinit {
    self.controlModel.removeAll()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    self.setupAttributes()
    self.setupConstraints()
  }

  private func setupAttributes() {
    self.view.backgroundColor = ColorReference.background
    
    guard let targetObject = self.controlModel.targetObject else { return }
    self.navigationItem.title = targetObject.rawValue
  }

  struct UI {
    static let paddingY: CGFloat = 24
    static let paddingX: CGFloat = 48
  }
  private func setupConstraints() {
    let subviews = [self.displayView!, self.tableView]
    subviews.forEach { self.view.addSubview($0) }

    let guide = self.view.safeAreaLayoutGuide
    self.displayView.snp.makeConstraints {
      $0.top.equalTo(guide).offset(UI.paddingY)
      $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(UI.paddingX)
      $0.height.equalTo(guide).multipliedBy(0.3)
    }

    self.tableView.snp.makeConstraints {
      $0.top.equalTo(self.displayView.snp.bottom).offset(UI.paddingY)
      $0.leading.trailing.bottom.equalTo(guide)
    }
  }
}

// MARK:- UITableViewDataSource

extension PropertyControlViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.controlModel.objects.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.controlModel.objects[section].object.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.controlModel.objects[section].properties.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let objectInfo = self.controlModel.objects[indexPath.section]
    let cell = self.cellProvider.createCell(with: objectInfo, for: indexPath)
    return cell
  }

}

// MARK:- ControlCellDelegate

extension PropertyControlViewController: ControlCellDelegate {

  func cell(_ tableViewCell: UITableViewCell, valueForColor color: UIColor?) {
    guard let cell = tableViewCell as? PaletteCell else { return }
    self.displayView.configure(color: color,
                               for: cell.currentProperty.name,
                               of: cell.currentObject)
  }

  func cell(_ tableViewCell: UITableViewCell, valueForToggle value: Bool) {
    guard let cell = tableViewCell as? ToggleCell else { return }
    self.displayView.configure(isOn: value,
                               for: cell.currentProperty.name,
                               of: cell.currentObject)
  }

  func cell(_ tableViewCell: UITableViewCell, valueForSlider value: Float) {
    guard let cell = tableViewCell as? SliderCell else { return }
    self.displayView.configure(value: value,
                               for: cell.currentProperty.name,
                               of: cell.currentObject)
  }

  func cell(_ tableViewCell: UITableViewCell, valueForTextField text: String) {
    guard let cell = tableViewCell as? TextCell else { return }
    self.displayView.configure(text: text,
                               for: cell.currentProperty.name,
                               of: cell.currentObject)
  }

  func cell(_ tableViewCell: UITableViewCell, valueForStepper value: Double) {
    guard let cell = tableViewCell as? StepperCell else { return }
    self.displayView.configure(value: value,
                               for: cell.currentProperty.name,
                               of: cell.currentObject)
  }

  func cell(_ tableViewCell: UITableViewCell, valuesForSelect values: [String]) {
    guard let cell = tableViewCell as? SelectCell else { return }
    self.presentActionSheet(values: values) { (rawValue, selected) in
      cell.configure(selectedValue: selected)
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

}
