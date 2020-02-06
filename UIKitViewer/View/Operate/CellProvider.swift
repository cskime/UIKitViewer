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
  @objc optional func cell(_ tableViewCell: UITableViewCell, valueForSelect value: Bool)
}

class CellProvider {
  
  weak var delegate: ControlCellDelegate?
  
  func register(to tableView: UITableView) {
    tableView.register(SliderCell.self, forCellReuseIdentifier: SliderCell.identifier)
    tableView.register(PaletteCell.self, forCellReuseIdentifier: PaletteCell.identifier)
    tableView.register(ToggleCell.self, forCellReuseIdentifier: ToggleCell.identifier)
    tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
    tableView.register(SelectCell.self, forCellReuseIdentifier: SelectCell.identifier)
  }
  
  func create(to tableView: UITableView, with title: String, for type: ControlType) -> UITableViewCell {
    switch type {
    case .slider:
      let cell = tableView.dequeueReusableCell(withIdentifier: SliderCell.identifier) as! SliderCell
      cell.configure(title: title)
      cell.delegate = self.delegate
      return cell
    case .palette:
      let cell = tableView.dequeueReusableCell(withIdentifier: PaletteCell.identifier) as! PaletteCell
      cell.configure(title: title)
      cell.delegate = self.delegate
      return cell
    case .toggle:
      let cell = tableView.dequeueReusableCell(withIdentifier: ToggleCell.identifier) as! ToggleCell
      cell.configure(title: title)
      cell.delegate = self.delegate
      return cell
    case .textField:
      let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as! TextCell
      cell.configure(title: title)
      cell.delegate = self.delegate
      return cell
    case .select:
      let cell = tableView.dequeueReusableCell(withIdentifier: SelectCell.identifier) as! SelectCell
      cell.configure(title: title)
      cell.delegate = self.delegate
      return cell
    }
  }
}
