//
//  CellManager.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class CellProvider {
  
  class func create(to tableView: UITableView, with title: String, for type: ControlType) -> UITableViewCell {
    switch type {
    case .slider:
      let cell = tableView.dequeueReusableCell(withIdentifier: SliderCell.identifier) as! SliderCell
      cell.configureContents(title: title)
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell") ?? UITableViewCell()
      cell.textLabel?.text = title
      return cell
    }
  }
  
}
