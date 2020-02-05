//
//  ObjectManager.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ObjectManager {
  
  static let shared = ObjectManager()
  private init() {}
  var dataSource = [ObjectInfo]()
  var object: ObjectProvider = .UIButton {
    didSet {
      object
        .classNamesWithinInheritance()
        .forEach {
          let classInfo = ObjectInfo(name: $0, properties: properties[$0] ?? [])
          self.dataSource.append(classInfo)
      }
    }
  }
  
}
