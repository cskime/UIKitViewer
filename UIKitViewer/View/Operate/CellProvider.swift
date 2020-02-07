//
//  CellManager.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

enum ControlType {
  case slider // 수치변화하는 control
  case palette // 색 고르는 control
  case textField //몇 가지 중에 고르는 control
  case toggle // true / false 중에 고르는 control
  case select
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
    self.register()
  }
  
  weak var delegate: ControlCellDelegate?
  
  private func register() {
    self.tableView.register(SliderCell.self, forCellReuseIdentifier: SliderCell.identifier)
    self.tableView.register(PaletteCell.self, forCellReuseIdentifier: PaletteCell.identifier)
    self.tableView.register(ToggleCell.self, forCellReuseIdentifier: ToggleCell.identifier)
    self.tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
    self.tableView.register(SelectCell.self, forCellReuseIdentifier: SelectCell.identifier)
  }
  
  func createCell(to tableView: UITableView, with title: String, forObjectType object: ObjectType, forControlType control: ControlType) -> UITableViewCell {
    let controlCell = self.dequeueCell(forControlType: control)
    controlCell.configure(title: title, from: object)
    controlCell.delegate = self.delegate
    return controlCell
  }
  
  private func dequeueCell(forControlType type: ControlType) -> ControlCell {
    switch type {
    case .slider:
      return self.tableView.dequeueReusableCell(withIdentifier: SliderCell.identifier) as! SliderCell
    case .palette:
      return self.tableView.dequeueReusableCell(withIdentifier: PaletteCell.identifier) as! PaletteCell
    case .toggle:
      return self.tableView.dequeueReusableCell(withIdentifier: ToggleCell.identifier) as! ToggleCell
    case .textField:
      return self.tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as! TextCell
    case .select:
      return self.tableView.dequeueReusableCell(withIdentifier: SelectCell.identifier) as! SelectCell
    }
  }
}
