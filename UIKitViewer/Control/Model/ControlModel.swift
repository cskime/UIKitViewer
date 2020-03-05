//
//  ControlModel.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

struct SliderSetup {
  var value: Float
  var minValue: Float
  var maxValue: Float
  
  init(value: Float = 0, minValue: Float = 0, maxValue: Float = 0) {
    self.value = value
    self.minValue = minValue
    self.maxValue = maxValue
  }
}

struct StepperSetup {
  var value: Int
  var minValue: Int
  var maxValue: Int
  
  init(value: Int = 0, minValue: Int = 0, maxValue: Int = 0) {
    self.value = value
    self.minValue = minValue
    self.maxValue = maxValue
  }
}

class ControlModel {
  static let shared = ControlModel()
  private init() { }
  
  // MARK: Control Data Source
  
  var objects = [ObjectInfo]()
  var targetObject: UIKitObject? { return self.objects.first?.object }
  
  func setupDataSource(for object: UIKitObject) {
    object.objectsWithinInheritance
      .forEach {
        let objectInfo = ObjectInfo(object: $0, properties: $0.properties)
        self.objects.append(objectInfo)
    }
  }
  
  private func removeDataSource() {
    self.objects.removeAll()
  }
  
  // MARK: Caching Cell Data
  
  private var controlValues = [UIKitObject: [String: Any]]()
  
  private func removeControlValues() {
    self.controlValues.removeAll()
  }
  
  func value(for property: String, of object: UIKitObject) -> Any? {
    guard self.controlValues[object] != nil else { return nil }
    return self.controlValues[object]![property]
  }
  
  func setValue(_ value: Any, for property: String, of object: UIKitObject) {
    guard self.controlValues[object] != nil else {
      self.controlValues[object] = [property: value]
      return
    }
    self.controlValues[object]![property] = value
  }
  
  func updateValue(_ value: Any, for property: String, of object: UIKitObject) {
    guard self.controlValues[object] != nil else { return }
    guard let oldValueSet = self.controlValues[object]![property] else { return }
    
    switch oldValueSet {
    case is SliderSetup:
      guard var sliderSetup = oldValueSet as? SliderSetup,
        let newValue = value as? Float else { return }
      sliderSetup.value = newValue
      self.controlValues[object]![property] = sliderSetup
    case is StepperSetup:
      guard var stepperSetup = oldValueSet as? StepperSetup,
        let newValue = value as? Int else { return }
      stepperSetup.value = newValue
      self.controlValues[object]![property] = stepperSetup
    case is Bool, is String:
      self.controlValues[object]![property] = value
    default:
      return
    }
  }
  
  // MARK: Deinitialize
  
  func removeAll() {
    self.removeDataSource()
    self.removeControlValues()
  }
}
