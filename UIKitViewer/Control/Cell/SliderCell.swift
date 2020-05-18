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
      self.valueLabel.text = String(format: "%.1f", newValue)
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
  
  override func configureContents() {
    let property = self.currentProperty.name
    let object = self.currentObject
    self.propertyLabel.configure(name: property)
    
    if let sliderSetup = ControlModel.shared.value(for: property, of: object) as? SliderSetup {
      self.setupSlider(with: sliderSetup)
    } else {
      let sliderSetup = self.initialSetup(for: self.propertyLabel.property,
                                           of: object)
      self.setupSlider(with: sliderSetup)
      ControlModel.shared.setValue(sliderSetup, for: property, of: object)
    }
  }
  
  // MARK: Actions
  
  @objc private func sliderChanged(_ sender: UISlider) {
    self.currentValue = sender.value
    let newSliderSetup = SliderSetup(value: sender.value,
                                     minValue: sender.minimumValue,
                                     maxValue: sender.maximumValue)
    ControlModel.shared.updateValue(newSliderSetup,
                                    for: self.currentProperty.name,
                                    of: self.currentObject)
    self.delegate?.cell(self, valueForSlider: sender.value)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: Slider Setup

extension SliderCell {
  private func setupSlider(with setup: SliderSetup) {
    self.slider.minimumValue = setup.minValue
    self.slider.maximumValue = setup.maxValue
    self.currentValue = setup.value
  }
  
  private func initialSetup(for property: String, of object: UIKitObject) -> SliderSetup {
    switch object {
    case .UIView:
      return self.initialSetupToView(for: property)
    case .UILabel:
      return self.initialSetupToLabel(for: property)
    case .UITextField:
      return self.initialSetupToTextField(for: property)
    case .UICollectionView:
      return self.initialSetupToCollectionView(for: property)
    default:
      return SliderSetup()
    }
  }
  
  private func initialSetupToView(for property: String) -> SliderSetup {
    let values: (value: Float, minValue: Float, maxValue: Float)
    switch property {
    case "alpha":                     values = (1, 0, 1)
    case "borderWidth":               values = (0, 0, 16)
    case "cornerRadius":              values = (0, 0, 100)
    default:                          values = (0, 0, 0)
    }
    return SliderSetup(value: values.0, minValue: values.1, maxValue: values.2)
  }
  
  private func initialSetupToLabel(for property: String) -> SliderSetup {
    let values: (value: Float, minValue: Float, maxValue: Float)
    switch property {
    case "minimumScaleFactor":        values = (0, 0, 1)
    default:                          values = (0, 0, 0)
    }
    return SliderSetup(value: values.0, minValue: values.1, maxValue: values.2)
  }
  
  private func initialSetupToTextField(for property: String) -> SliderSetup {
    let values: (value: Float, minValue: Float, maxValue: Float)
    switch property {
    case "minimumFontSize":           values = (0, 0, 17)
    default:                          values = (0, 0, 0)
    }
    return SliderSetup(value: values.0, minValue: values.1, maxValue: values.2)
  }
  
  private func initialSetupToCollectionView(for property: String) -> SliderSetup {
    let values: (value: Float, minValue: Float, maxValue: Float)
    switch property {
    case "itemSize":                  values = (50, 20, 80)
    case "minimumLineSpacing":        values = (10, 0, 32)
    case "minimumInteritemSpacing":   values = (10, 0, 32)
    case "sectionInset":              values = (0, 0, 32)
    case "headerReferenceSize":       values = (0, 0, 32)
    case "footerReferenceSize":       values = (0, 0, 32)
    default:                          values = (0, 0, 0)
    }
    return SliderSetup(value: values.0, minValue: values.1, maxValue: values.2)
  }
}
