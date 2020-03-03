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
    let property = objectInfo.properties[indexPath.row]
    let cell = self.cellProvider.create(
      withProperty: property.name, of: objectInfo.object, controlType: property.controlType
    )
    return cell
  }

}

// MARK:- ControlCellDelegate

extension PropertyControlViewController: ControlCellDelegate {

  func cell(_ tableViewCell: UITableViewCell, valueForColor color: UIColor?) {
    guard let cell = tableViewCell as? PaletteCell else { return }
    if cell.relates(to: "backgroundColor") {
      self.displayView.configure(backgroundColor: color)
    } else if cell.relates(to: "tint") {
      self.displayView.configure(tintColor: color)
    } else if cell.relates(to: "Title") || cell.relates(to: "text") {
      self.displayView.configure(textColor: color)
    } else if cell.relates(to: "border") {
      self.displayView.configure(borderColor: color)
    } else if cell.relates(to: "separator") {
      self.displayView.configureTableView(separatorColor: color)
    } else if cell.relates(to: "onTint") {
      self.displayView.configureSwitch(color: color, for: .onTint)
    } else if cell.relates(to: "thumbTint") {
      self.displayView.configureSwitch(color: color, for: .thumbTint)
    } else {
      return
    }
  }

  func cell(_ tableViewCell: UITableViewCell, valueForToggle value: Bool) {
    guard let cell = tableViewCell as? ToggleCell else { return }
    if cell.relates(to: "setImage") {
      self.displayView.configure(shouldSetImage: value, for: .default)
    } else if cell.relates(to: "setBackgroundImage") {
      self.displayView.configure(shouldSetImage: value, for: .background)
    } else if cell.relates(to: "isHidden"){
      self.displayView.configure(hidden: value)
    } else if cell.relates(to: "clipsToBounds"){
      self.displayView.configure(clipsToBounds: value)
    } else if cell.relates(to: "isOn") {
      self.displayView.configure(isOn: value)
    } else if cell.relates(to: "setOn") {
      self.displayView.configure(setOn: value)
    } else if cell.relates(to: "setDecrementImage") {
      self.displayView.configure(shouldSetImage: value, for: .decrement)
    } else if cell.relates(to: "setIncrementImage") {
      self.displayView.configure(shouldSetImage: value, for: .increment)
    } else if cell.relates(to: "setDividerImage") {
      self.displayView.configure(shouldSetImage: value, for: .divider)
    } else if cell.relates(to: "placeholder") {
      self.displayView.configureTextField(shouldDisplayPlaceholder: value)
    } else {
      return
    }
  }

  func cell(_ tableViewCell: UITableViewCell, valueForSlider value: Float) {
    guard let cell = tableViewCell as? SliderCell else { return }
    if cell.relates(to: "alpha") {
      self.displayView.configure(alpha: value)
    } else if cell.relates(to: "borderWidth") {
      self.displayView.configure(borderWidth: value)
    } else if cell.relates(to: "cornerRadius") {
      self.displayView.configure(cornerRadius: value)
    } else if cell.relates(to: "itemSize") {
      self.displayView.configureCollectionViewLayout(with: value, for: .itemSize)
    } else if cell.relates(to: "minimumInteritemSpacing") {
      self.displayView.configureCollectionViewLayout(with: value, for: .itemSpacing)
    } else if cell.relates(to: "minimumLineSpacing") {
      self.displayView.configureCollectionViewLayout(with: value, for: .lineSpacing)
    } else if cell.relates(to: "sectionInset") {
      self.displayView.configureCollectionViewLayout(with: value, for: .sectionInset)
    } else if cell.relates(to: "currentPage") {
      self.displayView.configurePageControl(with: value, for: .currentPage)
    } else if cell.relates(to: "numberOfPages") {
      self.displayView.configurePageControl(with: value, for: .numberOfPages)
    } else if cell.relates(to: "numberOfLines") {
      self.displayView.configureLabel(numberOfLines: value)
    } else {
      return
    }
  }

  func cell(_ tableViewCell: UITableViewCell, valueForTextField text: String) {
    self.displayView.configure(title: text)
  }


  func cell(_ tableViewCell: UITableViewCell, valueForSelect values: [String]) {
    guard let cell = tableViewCell as? SelectCell else { return }
    var actions = [UIAlertAction]()
    values
      .enumerated()
      .forEach { (index, title) in
        let action = UIAlertAction(title: title, style: .default) { _ in
          cell.configure(selectedValue: title)
          self.configureCases(with: cell.currentProperty, at: index)
        }
        actions.append(action)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    actions.append(cancelAction)


    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    actions.forEach { alert.addAction($0) }
    present(alert, animated: true)
  }

  private func configureCases(with title: String, at index: Int) {
    switch title {
    case "contentMode":
      self.displayView.configure(contentMode: UIView.ContentMode(rawValue: index) ?? .scaleToFill)
    case "style":
      self.displayView.configure(tableViewStyle: UITableView.Style(rawValue: index) ?? .plain)
    case "borderStyle":
      self.displayView.configure(textFieldBorderStyle: UITextField.BorderStyle(rawValue: index) ?? .none)
    case "clearButtonMode":
      self.displayView.configure(clearButtonMode: UITextField.ViewMode(rawValue: index) ?? .never)
    default:
      return
    }
  }

}
