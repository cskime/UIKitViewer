//
//  ClassModel.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

struct ClassInfo {
  var name: String
  var properties: [String]
}

enum ClassList: String {
  case UIView
  case UIButton
  case UILabel
  
  func getInstance() -> UIView? {
    guard let classType = NSClassFromString(self.rawValue) else { return nil }
    switch self {
    case .UIView:
      guard let viewType = classType as? UIView.Type else { return nil }
      return viewType.init()
    case .UILabel:
      guard let labelType = classType as? UILabel.Type else { return nil }
      return labelType.init()
    case .UIButton:
      guard let buttonType = classType as? UIButton.Type else { return nil }
      return buttonType.init()
    }
  }
  
  func getClass() -> AnyClass? {
    return NSClassFromString(self.rawValue)
  }
  
  func classNamesWithinInheritance() -> [String] {
    guard var current = self.getClass() else { return [] }
    var objects = [String(describing: current)]
    guard objects.first != "UIView" else { return objects }
    
    while let superClass = current.superclass() {
      let className = String(describing: superClass)
      objects.append(className)
      if className == "UIView" { return objects }
      else { current = superClass }
    }
    
    return objects
  }
}

class Manager {
  
  static let shared = Manager()
  private init() {}
  var dataSource = [ClassInfo]()
  var object: ClassList = .UIButton {
    didSet {
      let superClasses = object.classNamesWithinInheritance()
      superClasses.forEach {
        let classInfo = ClassInfo(name: $0, properties: properties[$0] ?? [])
        self.dataSource.append(classInfo)
      }
    }
  }
  
}
