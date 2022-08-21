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
    var value: Double
    var minValue: Double
    var maxValue: Double
    
    init(value: Double = 0, minValue: Double = 0, maxValue: Double = 0) {
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
    }
}

class ControlModel {
    static let shared = ControlModel()
    private init() { }
    
    // MARK: Control Data Source
    
    var objects = [UIKitObject]()
    var targetObject: UIKitObject? { objects.first }
    
    func setupDataSource(for object: UIKitObject) {
        objects = object.objectsWithinInheritance
    }
    
    private func removeDataSource() {
        objects.removeAll()
    }
    
    // MARK: Caching Cell Data
    
    private var controlValues = [UIKitObject: [String: Any]]()
    
    private func removeControlValues() {
        controlValues.removeAll()
    }
    
    func value(for property: String, of object: UIKitObject) -> Any? {
        guard controlValues[object] != nil else { return nil }
        return controlValues[object]![property]
    }
    
    func setValue(_ value: Any, for property: String, of object: UIKitObject) {
        guard controlValues[object] != nil else {
            controlValues[object] = [property: value]
            return
        }
        controlValues[object]![property] = value
    }
    
    func updateValue(_ value: Any, for property: String, of object: UIKitObject) {
        guard controlValues[object] != nil else { return }
        guard let oldValueSet = controlValues[object]![property] else { return }
        
        switch oldValueSet {
        case is SliderSetup:
            guard let newValue = value as? SliderSetup else { return }
            controlValues[object]![property] = newValue
        case is StepperSetup:
            guard let newValue = value as? StepperSetup else { return }
            controlValues[object]![property] = newValue
        default:
            controlValues[object]![property] = value
        }
    }
    
    // MARK: Deinitialize
    
    func removeAll() {
        removeDataSource()
        removeControlValues()
    }
}
