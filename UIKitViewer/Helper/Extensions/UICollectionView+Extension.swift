//
//  UICollectionView+Extension.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

extension UICollectionViewCell: Identifiable { }

extension UICollectionView {
  func register<Cell>(_ cell: Cell.Type) where Cell: UICollectionViewCell {
    self.register(cell, forCellWithReuseIdentifier: cell.identifier)
  }
  
  func dequeueCell<Cell>(_ cell: Cell.Type, indexPath: IndexPath) -> Cell? where Cell: UICollectionViewCell {
    return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? Cell
  }
}

