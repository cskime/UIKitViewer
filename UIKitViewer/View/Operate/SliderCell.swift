//
//  SliderCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit


class SliderCell: UITableViewCell {
  
  static let identifier = String(describing: SliderCell.self)
  
  weak var delegate: ControlCellDelegate?
  
  private var currentValue: Float {
    get { return self.slider.value }
    set {
      self.valueLabel.text = String(format: "%.1f", newValue)
      self.slider.value = newValue
    }
  }
  private let valueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.text = "0"
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  private var slider = UISlider()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    print("Cell Init")
    self.setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    print("Cell Reuse")
  }
  
  private func setupUI() {
    self.slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    let subviews = [self.nameLabel, self.slider, self.valueLabel]
    subviews.forEach {
      self.contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      
      self.valueLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.valueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
      self.valueLabel.bottomAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
      
      self.slider.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.spacing),
      self.slider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX * 2),
      self.slider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX * 2),
      self.slider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  
  // MARK: Interface
  
  
  func configure(title: String) {
    if let sliderValues = ObjectManager.shared.values(for: title) as? SliderValueSet {
      self.setupSlider(valueType: .custom(sliderValues.value),
                       minValue: sliderValues.minValue,
                       maxValue: sliderValues.maxValue)
    } else {
      let sliderValues = self.initializeSlider(for: title)
      ObjectManager.shared.addValue(sliderValues, for: title)
    }
    self.nameLabel.text = title
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.nameLabel.text!.contains(propertyName)
  }
  
  // MARK: Actions
  
  @objc private func sliderChanged(_ sender: UISlider) {
    self.currentValue = sender.value
    ObjectManager.shared.updateSliderValue(sender.value, for: self.nameLabel.text ?? "")
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
