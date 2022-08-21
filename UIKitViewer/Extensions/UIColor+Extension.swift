//
//  UIColor+Extension.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
    self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
  }
}

