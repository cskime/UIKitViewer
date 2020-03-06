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
  
  private var currentValue: Double {
    get { return self.stepper.value }
    set {
      self.stepper.value = newValue
      switch self.currentObject {
      case .UIPageControl:
        self.valueLabel.text = Int(newValue).description
      default:
        self.valueLabel.text = newValue.description
      }
      
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
  
  deinit {
    NotificationCenter.default.removeObserver(self)
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
    self.configureStepper(title: title, object: object)
    self.addPageControlObserver(to: title)
  }
  
  private func configureStepper(title: String, object: UIKitObject) {
    if let stepperValues = ControlModel.shared.value(for: title, of: object) as? StepperSetup {
      self.setupStepper(value: stepperValues.value,
                        minValue: stepperValues.minValue,
                        maxValue: stepperValues.maxValue)
    } else {
      let stepperValues = self.initializeStepper(for: title)
      ControlModel.shared.setValue(stepperValues, for: title, of: object)
    }
  }
  
  private let pageControlNumberOfPagesDidChangeNotification = NSNotification.Name(rawValue: "pageControlNumberOfPagesDidChange")
  private func addPageControlObserver(to property: String) {
    if property.contains("currentPage") {
      NotificationCenter
        .default
        .addObserver(self,
                     selector: #selector(updateCurrentPageStepper),
                     name: self.pageControlNumberOfPagesDidChangeNotification,
                     object: nil)
    }
  }
  
  // MARK: Methods
  
  private func initializeStepper(for property: String) -> StepperSetup {
    switch property {
    case "numberOfLines":
      self.setupStepper(value: 1, minValue: 0, maxValue: 5)
    case "currentPage":
      self.setupStepper(value: 0, minValue: 0, maxValue: 2)
    case "numberOfPages":
      self.setupStepper(value: 3, minValue: 0, maxValue: 7)
    case "minimumValue":
      self.setupStepper(value: 0, minValue: 0, maxValue: 5)
    case "maximumValue":
      self.setupStepper(value: 5, minValue: 0, maxValue: 5)
    case "stepValue":
      self.setupStepper(value: 1, minValue: 0.2, maxValue: 1)
      self.stepper.stepValue = 0.2
    default:
      print("Unknown")
      return StepperSetup()
    }
    self.delegate?.cell(self, valueForStepper: self.stepper.value)
    return StepperSetup(value: self.stepper.value,
                        minValue: self.stepper.minimumValue,
                        maxValue: self.stepper.maximumValue)
  }
  
  private func setupStepper(value: Double, minValue: Double, maxValue: Double) {
    self.stepper.minimumValue = minValue
    self.stepper.maximumValue = maxValue
    self.currentValue = value
  }
  
  // MARK: Actions
  
  @objc private func stepperChanged(_ sender: UIStepper) {
    self.currentValue = sender.value
    self.postPageControlNotification(userInfo: ["numberOfPages": sender.value])
    self.updateStepperSetup(sender)
    self.delegate?.cell(self, valueForStepper: sender.value)
  }
  
  private func updateStepperSetup(_ stepper: UIStepper) {
    let newStepperSetup = StepperSetup(value: stepper.value,
                                       minValue: stepper.minimumValue,
                                       maxValue: stepper.maximumValue)
    ControlModel.shared.updateValue(newStepperSetup,
                                    for: self.currentProperty.name,
                                    of: self.currentObject)
  }
  
  private func postPageControlNotification(userInfo: [String: Double]? = nil) {
    if self.currentProperty.name.contains(userInfo?.keys.first ?? "") {
      NotificationCenter.default.post(name: self.pageControlNumberOfPagesDidChangeNotification,
                                      object: nil,
                                      userInfo: userInfo)
    }
  }
  
  @objc private func updateCurrentPageStepper(_ noti: Notification) {
    guard self.propertyLabel.property.contains("currentPage"),
      let userInfo = noti.userInfo as? [String: Double],
      let numberOfPages = userInfo["numberOfPages"]
      else { return }
    let currentPage = self.currentValue
    let maxPage = numberOfPages - 1
    self.stepper.maximumValue = maxPage
    self.currentValue = numberOfPages > currentPage ? currentPage : maxPage
    self.updateStepperSetup(self.stepper)
  }
  
  // MARK: Useless
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
