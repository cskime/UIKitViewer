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
  private lazy var displayView = DisplayView(objectType: self.dataSource.first!.object)

  // MARK: Model

  private var dataSource = [ObjectInfo]()

  // MARK: Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }

  // MARK: Initialize

  init(object: UIKitObject) {
    super.init(nibName: nil, bundle: Bundle.main)
    let model = ControlModel(object: object)
    self.dataSource = model.objects
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
    self.navigationItem.title = "\(self.dataSource.first!.object)"
  }

  struct UI {
    static let paddingY: CGFloat = 24
    static let paddingX: CGFloat = 48
  }
  private func setupConstraints() {
    let subviews = [self.displayView, self.tableView]
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
//    return objectManager.dataSource.count
    return self.dataSource.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    return objectManager.dataSource[section].name
    return self.dataSource[section].object.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource[section].properties.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let objectInfo = self.dataSource[indexPath.section]
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


  func cell(_ tableViewCell: UITableViewCell, valuesForSelect values: [String]) {
    guard let cell = tableViewCell as? SelectCell else { return }
    var actions = [UIAlertAction]()
    values
      .enumerated()
      .forEach { (index, title) in
        let action = UIAlertAction(title: title, style: .default) { _ in
          cell.configure(selectedValue: title)
          self.displayView.configure(rawValue: index,
                                     property: cell.currentProperty.name,
                                     of: cell.currentObject)
        }
        actions.append(action)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    actions.append(cancelAction)


    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    actions.forEach { alert.addAction($0) }
    present(alert, animated: true)
  }

}
