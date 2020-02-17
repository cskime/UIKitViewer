//
//  ObjectManager.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

typealias SliderValueSet = (value: Float, minValue: Float, maxValue: Float)

struct ObjectInfo {
    var name: String
    var properties: [Property]
}

class ObjectManager {
  
  static let shared = ObjectManager()
  private init() {}
  
  // MARK: Using table view data source
  
  var dataSource = [ObjectInfo]()
  var object: ObjectType = .UIButton {
    didSet {
      object
        .classNamesWithinInheritance()
        .forEach {
          let objectInfo = ObjectInfo(name: $0, properties: properties[$0] ?? [])
          self.dataSource.append(objectInfo)
      }
      let layer = properties.filter { $0.key == "CALayer" }.first
      let layerInfo = ObjectInfo(name: layer?.key ?? "", properties: layer?.value ?? [])
      self.dataSource.append(layerInfo)
      
      if object == .UICollectionView {
        let layout = properties.filter { $0.key == "UICollectionViewFlowLayout" }.first
        let objectInfo = ObjectInfo(name: layout?.key ?? "", properties: layout?.value ?? [])
        self.dataSource.insert(objectInfo, at: 1)
      }
    }
  }
  
  // MARK: Using table view cell data cache
  
  private var valuesForObjects = [String: Any]()
  
  func addValue(_ value: Any, for key: String) {
    self.valuesForObjects[key] = value
  }
  
  func updateValue(_ value: Any, for key: String) {
    self.valuesForObjects.updateValue(value, forKey: key)
  }
  
  func updateSliderValue(_ value: Float, for key: String) {
    guard var values = valuesForObjects[key] as? SliderValueSet else { return }
    values.value = value
    self.valuesForObjects.updateValue(values, forKey: key)
  }
  
  func values(for key: String) -> Any? {
    return valuesForObjects[key]
  }
  
  func removeAllValues() {
    self.valuesForObjects.removeAll()
  }
  
}
