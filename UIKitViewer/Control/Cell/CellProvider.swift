//
//  CellManager.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then

enum ControlType {
  case slider // 수치변화하는 control
  case palette // 색 고르는 control
  case textField //몇 가지 중에 고르는 control
  case toggle // true / false 중에 고르는 control
  case select
  
  var cell: ControlCell.Type {
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
  @objc optional func cell(_ tableViewCell: UITableViewCell, valuesForSelect values: [String])
}

class ControlCell: UITableViewCell {
  var currentObject: UIKitObject = .UIView
  var currentProperty: PropertyInfo = PropertyInfo(name: "", controlType: .slider)
  weak var delegate: ControlCellDelegate?
  func configure(object: UIKitObject, property: PropertyInfo) { }
}

class CellProvider: Then {
  
  private let tableView: UITableView
  init(tableView: UITableView) {
    self.tableView = tableView
  }
  
  weak var delegate: ControlCellDelegate?
  
  func createCell(with objectInfo: ObjectInfo, for indexPath: IndexPath) -> UITableViewCell {
    let propertyInfo = objectInfo.properties[indexPath.row]
    let controlType = propertyInfo.controlType
    
    self.tableView.register(controlType.cell)
    guard let cell = self.tableView.dequeueCell(controlType.cell) else { return UITableViewCell() }
    cell.configure(object: objectInfo.object, property: propertyInfo)
    cell.delegate = self.delegate
    return cell
  }
}
