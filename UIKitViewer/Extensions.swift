//
//  Extensions.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/06.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
  @IBInspectable
  var borderWidth: Double {
    get { Double(self.layer.borderWidth) }
    set { self.layer.borderWidth = CGFloat(newValue) }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      guard let cgColor = self.layer.borderColor else { return nil }
      return UIColor(cgColor: cgColor)
    }
    set {
      self.layer.borderColor = newValue?.cgColor
    }
  }
}
