//
//  OperationViewController.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController {
  
  private let cellProvider = CellProvider()
  private let objectManager = ObjectManager.shared
  private let tableView = UITableView(frame: .zero, style: .grouped)
  private lazy var displayView = DisplayView(objectType: self.objectManager.object)
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  deinit {
    self.objectManager.dataSource.removeAll()
    self.objectManager.removeAllValues()
  }
  
  // MARK: Initialize
  
  private func setupUI() {
    self.setupAttributes()
    self.setupTableView()
    self.setupConstraints()
    self.cellProvider.delegate = self
    self.cellProvider.register(to: self.tableView)
  }
  
  private func setupAttributes() {
    self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
    navigationItem.title = objectManager.dataSource.first?.name
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.allowsSelection = false
  }
  
  struct UI {
    static let paddingY: CGFloat = 24
    static let paddingX: CGFloat = 24
  }
  private func setupConstraints() {
    let subviews = [self.displayView, self.tableView]
    subviews.forEach {
      self.view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let guide = self.view.safeAreaLayoutGuide
    self.displayView.backgroundColor = .lightText
    NSLayoutConstraint.activate([
      self.displayView.topAnchor.constraint(equalTo: guide.topAnchor, constant: UI.paddingY),
      self.displayView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX),
      self.displayView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -UI.paddingX),
      self.displayView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3),
      
      self.tableView.topAnchor.constraint(equalTo: self.displayView.bottomAnchor, constant: UI.paddingY),
      self.tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
    ])
  }
}
// MARK:- UITableViewDataSource

extension OperationViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return objectManager.dataSource.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return objectManager.dataSource[section].name
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objectManager.dataSource[section].properties.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let property = objectManager.dataSource[indexPath.section].properties[indexPath.row]
    let cell = self.cellProvider.createCell(to: tableView, with: property.name, forObjectType: objectManager.object, forControlType: property.controlType)
    return cell
  }
  
}

// MARK:- ControlCellDelegate

extension OperationViewController: ControlCellDelegate {
  
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
