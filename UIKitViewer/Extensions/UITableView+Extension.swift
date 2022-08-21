//
//  UITableView+Extension.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

extension UITableViewCell: Identifiable { }

extension UITableView {
  func register<Cell>(_ cell: Cell.Type) where Cell: UITableViewCell {
    self.register(cell, forCellReuseIdentifier: cell.identifier)
  }
  
  func dequeueCell<Cell>(_ cell: Cell.Type, indexPath: IndexPath? = nil) -> Cell? where Cell: UITableViewCell {
    guard let indexPath = indexPath else {
      return self.dequeueReusableCell(withIdentifier: cell.identifier) as? Cell
    }
    return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? Cell
  }
}

