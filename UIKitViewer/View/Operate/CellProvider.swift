//
//  CellManager.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

enum CellControlType {
  case slider // 수치변화하는 control
  case palette // 색 고르는 control
  case textField //몇 가지 중에 고르는 control
  case toggle // true / false 중에 고르는 control
  case select
  
  var cellType: ControlCell.Type {
    get {
      switch self {
      case .slider:     return SliderCell.self
      case .palette:    return PaletteCell.self
      case .textField:  return TextCell.self
      case .toggle:     return ToggleCell.self
      case .select:     return SelectCell.self
      }
    }
  }
}

@objc protocol ControlCellDelegate {
  @objc optional func cell(_ tableViewCell: UITableViewCell, valueForColor color: UIColor?)
  @objc optional func cell(_ tableViewCell: UITableViewCell, valueForSlider value: Float)
  @objc optional func cell(_ tableViewCell: UITableViewCell, valueForToggle value: Bool)
  @objc optional func cell(_ tableViewCell: UITableViewCell, valueForTextField text: String)
  @objc optional func cell(_ tableViewCell: UITableViewCell, valueForSelect values: [String])
}

class ControlCell: UITableViewCell {
  weak var delegate: ControlCellDelegate?
  func configure(title: String, from object: ObjectType) { }
}

class CellProvider {
  
  private let tableView: UITableView
  init(tableView: UITableView) {
    self.tableView = tableView
  }
  
  weak var delegate: ControlCellDelegate?
  
  func create(withProperty name: String, of object: ObjectType, controlType control: CellControlType) -> UITableViewCell {
    self.register(of: control.cellType)
    let controlCell = self.dequeueReusableCell(of: control.cellType)
    controlCell.configure(title: name, from: object)
    controlCell.delegate = self.delegate
    return controlCell
  }
  
  private func register<T: ControlCell>(of type: T.Type) {
    self.tableView.register(type, forCellReuseIdentifier: String(describing: type))
  }
  
  private func dequeueReusableCell<T: ControlCell>(of type: T.Type) -> T {
    return self.tableView.dequeueReusableCell(withIdentifier: String(describing: type)) as! T
  }
}
