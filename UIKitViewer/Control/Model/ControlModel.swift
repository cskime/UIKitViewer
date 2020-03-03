//
//  ControlModel.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

struct ControlModel {
  var objects = [ObjectInfo]()
  
  init(object: UIKitObject) {
    object.objectsWithinInheritance
      .forEach {
        let objectInfo = ObjectInfo(object: $0, properties: $0.properties)
        self.objects.append(objectInfo)
    }
  }
}
