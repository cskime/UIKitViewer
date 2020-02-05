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
  var object: ObjectType = .UIButton {
    didSet {
      object
        .classNamesWithinInheritance()
        .forEach {
          let objectInfo = ObjectInfo(name: $0, properties: properties[$0] ?? [])
          self.dataSource.append(objectInfo)
      }
      if object == .UICollectionView {
        let layout = properties.filter { $0.key == "UICollectionViewFlowLayout" }.first
        let objectInfo = ObjectInfo(name: layout?.key ?? "", properties: layout?.value ?? [])
        self.dataSource.insert(objectInfo, at: 1)
      }
    }
  }
  
}
