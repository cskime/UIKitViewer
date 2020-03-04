//
//  SliderCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then
import SnapKit

class SliderCell: ControlCell {
  
  // MARK: Properties
  
  private var currentValue: Float {
    get { return self.slider.value }
    set {
      self.valueLabel.text = String(format: "%.2f", newValue)
      self.slider.value = newValue
    }
  }
  
  // MARK: Views
  
  private let propertyLabel = PropertyLabel()
  
  private let valueLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 18)
    $0.textColor = ColorReference.subText
  }
  
  private lazy var slider = UISlider().then {
    $0.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
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
    [self.propertyLabel, self.slider, self.valueLabel]
      .forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: 0, right: 0))
    }
    
    self.slider.snp.makeConstraints {
      $0.top.equalTo(self.propertyLabel.snp.bottom).offset(UI.spacing / 2)
      $0.leading.equalTo(self.propertyLabel).offset(UI.spacing)
      $0.bottom.equalTo(self.contentView).offset(-UI.paddingY)
    }
    
    self.valueLabel.snp.makeConstraints {
      $0.leading.equalTo(self.slider.snp.trailing).offset(UI.paddingX)
      $0.centerY.equalTo(self.slider)
      $0.trailing.equalTo(self.contentView).offset(-UI.paddingX)
    }
  }
  
  // MARK: Interface
  
  override func configure(title: String, from object: UIKitObject) {
    self.propertyLabel.configure(name: title)
    
    if let sliderValues = ObjectManager.shared.values(for: title) as? SliderValueSet {
      self.setupSlider(valueType: .custom(sliderValues.value),
                       minValue: sliderValues.minValue,
                       maxValue: sliderValues.maxValue)
    } else {
      let sliderValues = self.initializeSlider(for: self.propertyLabel.property)
      ObjectManager.shared.addValue(sliderValues, for: title)
    }
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.propertyLabel.property.contains(propertyName)
  }
  
  // MARK: Actions
  
  @objc private func sliderChanged(_ sender: UISlider) {
    self.currentValue = sender.value
    ObjectManager.shared.updateSliderValue(sender.value, for: self.propertyLabel.property)
    delegate?.cell?(self, valueForSlider: sender.value)
  }
  
  // MARK: Methods
  
  private enum SliderValue {
    case minimum
    case maximum
    case median
    case custom(Float)
  }
  private func setupSlider(valueType: SliderValue, minValue: Float, maxValue: Float) {
    self.slider.minimumValue = minValue
    self.slider.maximumValue = maxValue
    
    let value: Float
    switch valueType {
    case .minimum:
      value = self.slider.minimumValue
    case .maximum:
      value = self.slider.maximumValue
    case .median:
      value = (self.slider.minimumValue + self.slider.maximumValue) / 2
    case .custom(let customValue):
      value = customValue
    }
    self.currentValue = value
  }
  
  private func initializeSlider(for title: String) -> SliderValueSet {
    switch title {
    case "alpha":
      self.setupSlider(valueType: .maximum, minValue: 0, maxValue: 1)
    case "borderWidth":
      self.setupSlider(valueType: .minimum, minValue: 0, maxValue: 16)
    case "cornerRadius":
      self.setupSlider(valueType: .minimum, minValue: 0, maxValue: 100)
    case "itemSize":
      self.setupSlider(valueType: .custom(50), minValue: 20, maxValue: 80)
    case "minimumLineSpacing":
      self.setupSlider(valueType: .minimum, minValue: 10, maxValue: 32)
    case "minimumInteritemSpacing":
      self.setupSlider(valueType: .minimum, minValue: 10, maxValue: 32)
    case "sectionInset":
      self.setupSlider(valueType: .minimum, minValue: 0, maxValue: 32)
    case "headerReferenceSize":
      self.setupSlider(valueType: .minimum, minValue: 0, maxValue: 0)
    case "footerReferenceSize":
      self.setupSlider(valueType: .minimum, minValue: 0, maxValue: 0)
    case "currentPage":
      self.setupSlider(valueType: .minimum, minValue: 0, maxValue: 10)
    case "numberOfPages":
      self.setupSlider(valueType: .minimum, minValue: 3, maxValue: 10)
    case "numberOfLines":
      self.setupSlider(valueType: .custom(1), minValue: 0, maxValue: 5)
    default:
      print("Unknown")
      return (0, 0, 0)
    }
    return (self.slider.value, self.slider.minimumValue, self.slider.maximumValue)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
