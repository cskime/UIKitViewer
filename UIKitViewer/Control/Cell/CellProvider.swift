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
  case slider
  case palette
  case textField
  case toggle
  case select
  case stepper
  case methodCall
  
  var cell: ControlCell.Type {
    get {
      switch self {
      case .slider:     return SliderCell.self
      case .palette:    return PaletteCell.self
      case .textField:  return TextCell.self
      case .toggle:     return ToggleCell.self
      case .select:     return SelectCell.self
      case .stepper:    return StepperCell.self
      case .methodCall: return MethodCell.self
      }
    }
  }
}

protocol ControlCellDelegate: class {
  func cell(_ tableViewCell: UITableViewCell, valueForColor color: UIColor?)
  func cell(_ tableViewCell: UITableViewCell, valueForSlider value: Float)
  func cell(_ tableViewCell: UITableViewCell, valueForToggle value: Bool)
  func cell(_ tableViewCell: UITableViewCell, valueForTextField text: String)
  func cell(_ tableViewCell: UITableViewCell, valuesForSelect values: [String])
  func cell(_ tableViewCell: UITableViewCell, valueForStepper value: Double)
  func cellWillCallMethod(_ tableViewCell: UITableViewCell)
}

class ControlCell: UITableViewCell {
  var currentObject: UIKitObject = .UIView
  var currentProperty: PropertyInfo = PropertyInfo(name: "", controlType: .slider)
  
  weak var delegate: ControlCellDelegate?
  
  final func configure(object: UIKitObject, property: PropertyInfo) {
    self.currentObject = object
    self.currentProperty = property
  }
  
  func configureContents() { }
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
    cell.delegate = self.delegate
    cell.configure(object: objectInfo.object, property: propertyInfo)
    cell.configureContents()
    return cell
  }
}
