//
//  Common.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/09.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

enum ImageReference {
  static let dummy = UIImage(named: "dummy")
  static let clearColor = UIImage(named: "clearcolor")
  static let minus = UIImage(systemName: "minus")
  static let plus = UIImage(systemName: "plus")
}

enum ColorReference {
  static let borderColor: UIColor? = #colorLiteral(red: 0.8999999762, green: 0.8999999762, blue: 0.8999999762, alpha: 1)
  static let background: UIColor? = UIColor(red: 242, green: 242, blue: 247)
  static let subText: UIColor = UIColor(red: 130, green: 130, blue: 130)
  
  enum Default {
    enum View {
      static let backgroundColor: UIColor = .clear
      static let tintColor: UIColor = #colorLiteral(red: 0.006840246264, green: 0.477968514, blue: 0.9983579516, alpha: 1)
      static let borderColor: UIColor = .clear
    }
    enum Button {
      static let titleColor: UIColor = #colorLiteral(red: 0.006840246264, green: 0.477968514, blue: 0.9983579516, alpha: 1)
    }
    enum Label {
      static let textColor: UIColor = .black
    }
    enum PageControl {
      static let pageIndicatorTintColor: UIColor = UIColor.white.withAlphaComponent(0.2)
      static let currentPageIndicatorTintColor: UIColor = .white
    }
    enum Switch {
      static let onTintColor: UIColor = #colorLiteral(red: 0.1191028133, green: 0.7923710942, blue: 0.3873175979, alpha: 1)
      static let thumbTintColor: UIColor = .white
    }
    enum Slider {
      static let thumbTintColor: UIColor = .white
      static let minimumTrackTintColor: UIColor = #colorLiteral(red: 0, green: 0.5383808613, blue: 1, alpha: 1)
      static let maximumTrackTintColor: UIColor = #colorLiteral(red: 0.9075521827, green: 0.908038497, blue: 0.9146741629, alpha: 1)
    }
    enum TextField {
      static let textColor: UIColor = .black
    }
    enum TableView {
      static let separatorColor: UIColor = #colorLiteral(red: 0.8027285933, green: 0.8032106161, blue: 0.810041368, alpha: 1)
    }
  }
}

