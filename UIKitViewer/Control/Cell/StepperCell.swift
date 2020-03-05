//
//  StepperCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then
import SnapKit

class StepperCell: ControlCell {
  
  // MARK: Properties
  
  private var currentValue: Int {
    get { return Int(self.stepper.value) }
    set {
      self.valueLabel.text = Int(self.stepper.value).description
    }
  }
  
  // MARK: Views
  
  private let propertyLabel = PropertyLabel()
  private let valueLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 18)
    $0.textColor = ColorReference.subText
  }
  private lazy var stepper = UIStepper().then {
    $0.wraps = false
    $0.autorepeat = false
    $0.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
  }
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 20
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    [self.propertyLabel, self.valueLabel, self.stepper]
      .forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading.bottom
        .equalToSuperview()
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: UI.paddingY, right: 0))
    }
    
    self.stepper.snp.makeConstraints {
      $0.centerY.equalTo(self.propertyLabel)
      $0.trailing.equalToSuperview().offset(-UI.paddingX)
    }
    
    self.valueLabel.snp.makeConstraints {
      $0.centerY.equalTo(self.propertyLabel)
      $0.trailing.equalTo(self.stepper.snp.leading).offset(-UI.spacing)
    }
  }
  
  // MARK: Interface
  
  override func configureContents() {
    let title = self.currentProperty.name
    let object = self.currentObject
    self.propertyLabel.configure(name: title)
    
    if let stepperValues = ControlModel.shared.value(for: title, of: object) as? StepperSetup {
      self.setupStepper(value: stepperValues.value, maxValue: stepperValues.maxValue)
    } else {
      let stepperValues = self.initializeStepper(for: title)
      ControlModel.shared.setValue(stepperValues, for: title, of: object)
    }
  }
  
  // MARK: Methods
  
  private func setupStepper(value: Int = 0, minValue: Int = 0, maxValue: Int) {
    self.stepper.minimumValue = Double(minValue)
    self.stepper.maximumValue = Double(maxValue)
    self.stepper.value = Double(value)
    self.valueLabel.text = value.description
  }
  
  private func initializeStepper(for property: String) -> StepperSetup {
    switch property {
    case "numberOfLines":
      self.setupStepper(value: 1, maxValue: 5)
    case "currentPage":
      self.setupStepper(maxValue: 7)
    case "numberOfPages":
      self.setupStepper(value: 3, maxValue: 7)
    default:
      print("Unknown")
      return StepperSetup()
    }
    return StepperSetup(value: Int(self.stepper.value),
                        minValue: Int(self.stepper.minimumValue),
                        maxValue: Int(self.stepper.maximumValue))
  }
  
  // MARK: Actions
  
  @objc private func stepperChanged(_ sender: UIStepper) {
    self.currentValue = Int(sender.value)
    ControlModel.shared.updateValue(Int(sender.value),
                                    for: self.currentProperty.name,
                                    of: self.currentObject)
    self.delegate?.cell(self, valueForStepper: self.currentValue)
  }
  
  // MARK: Useless
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
