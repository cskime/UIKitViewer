//
//  UICollectionView+Extension.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

//extension UICollectionViewCell: Identifiable { }
extension UICollectionReusableView: Identifiable { }

extension UICollectionView {
  func register<Cell>(_ cell: Cell.Type) where Cell: UICollectionViewCell {
    self.register(cell, forCellWithReuseIdentifier: cell.identifier)
  }
  
  enum ReusableViewKind {
    case header
    case footer
    var kind: String {
      switch self {
      case .header:
        return UICollectionView.elementKindSectionHeader
      case .footer:
        return UICollectionView.elementKindSectionFooter
      }
    }
  }
  
  func register<ReusableView>(_ reusableView: ReusableView.Type, kind: ReusableViewKind) where ReusableView: UICollectionReusableView {
    self.register(reusableView,
                  forSupplementaryViewOfKind: kind.kind,
                  withReuseIdentifier: reusableView.identifier)
  }
  
  func dequeueCell<Cell>(_ cell: Cell.Type, indexPath: IndexPath) -> Cell? where Cell: UICollectionViewCell {
    return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? Cell
  }
  
  func dequeueReusableView<ReusableView>(_ reusableView: ReusableView.Type, kind: String, indexPath: IndexPath) -> ReusableView where ReusableView: UICollectionReusableView {
    return self.dequeueReusableSupplementaryView(ofKind: kind,
                                                 withReuseIdentifier: reusableView.identifier,
                                                 for: indexPath) as! ReusableView
  }
}
