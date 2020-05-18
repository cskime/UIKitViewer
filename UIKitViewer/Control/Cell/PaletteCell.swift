//
//  PaletteCellTableViewCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class PaletteCell: ControlCell {
  
  // MARK: Views
  
  private let colors: [UIColor] = [.clear, .black, .white, .red, .green, .blue]
  private var colorButtons = [UIButton]()
  
  private let propertyLabel = PropertyLabel()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.colors.enumerated().forEach { (index, color) in
      let button = UIButton().then { (button) in
        button.tag = index + 10
        button.backgroundColor = color
        button.addTarget(self, action: #selector(paletteTouched(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderWidth = color == .white ? 0.5 : 0
      }
      self.colorButtons.append(button)
    }
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 20
    static let spacing: CGFloat = 8
    static let deselectedAlpha: CGFloat = 0.3
  }
  private let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.alignment = .fill
    $0.distribution = .fillProportionally
    $0.spacing = 24
  }
  private func setupConstraints() {
    self.colorButtons.forEach {
      stackView.addArrangedSubview($0)
      $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    let divider = UIView().then {
      $0.backgroundColor = .gray
    }
    self.stackView.insertArrangedSubview(divider, at: 1)
    divider.snp.makeConstraints { $0.width.equalTo(1) }
    
    [self.propertyLabel, self.stackView].forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: 0, right: 0))
    }
    
    self.stackView.snp.makeConstraints {
      $0.top.equalTo(self.propertyLabel.snp.bottom).offset(UI.spacing)
      $0.leading.equalTo(self.propertyLabel).offset(UI.spacing)
      $0.trailing.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: 0, left: 0, bottom: UI.paddingY, right: UI.paddingX))
    }
  }
  
  // MARK: Interface
  
  override func configureContents() {
    let title = self.currentProperty.name
    let object = self.currentObject
    self.propertyLabel.configure(name: title)
    
    guard let defaultColorButton = self.colorButtons.first else { return }
    self.initializeDefaultColor(to: defaultColorButton)
    
    if let selectedTag = ControlModel.shared.value(for: title, of: object) as? Int {
      self.colorButtons.filter { $0.tag == selectedTag }.forEach {
        self.highlightSelectedButton($0)
      }
    } else {
      self.highlightSelectedButton(defaultColorButton)
      ControlModel.shared.setValue(defaultColorButton.tag, for: title, of: object)
    }
  }
  
  private func initializeDefaultColor(to button: UIButton) {
    let defaultColor = self.defaultColor(ColorReference.Default.self)
    button.backgroundColor = defaultColor
    let clearImage = defaultColor == .clear ? ImageReference.clearColor : nil
    button.setBackgroundImage(clearImage, for: .normal)
    let hasBorderWidth = (defaultColor == .clear) ||
      (defaultColor == .white) ||
      (defaultColor == ColorReference.Default.PageControl.pageIndicatorTintColor)
    button.layer.borderWidth = hasBorderWidth ? 0.5 : 0
  }
  
  private func defaultColor(_ defaultColor: ColorReference.Default.Type) -> UIColor {
    switch self.currentProperty.name {
    case "backgroundColor":
      return defaultColor.View.backgroundColor
    case "tintColor":
      return defaultColor.View.tintColor
    case "layer.borderColor":
      return defaultColor.View.borderColor
    case "setTitleColor":
      return defaultColor.Button.titleColor
    case "textColor":
      return defaultColor.Label.textColor
    case "separatorColor":
      return defaultColor.TableView.separatorColor
    case "onTintColor":
      return defaultColor.Switch.onTintColor
    case "thumbTintColor":
      if self.currentObject == .UISwitch {
        return defaultColor.Switch.thumbTintColor
      } else {
        return defaultColor.Slider.thumbTintColor
      }
    case "pageIndicatorTintColor":
      return defaultColor.PageControl.pageIndicatorTintColor
    case "currentPageIndicatorTintColor":
      return defaultColor.PageControl.currentPageIndicatorTintColor
    case "minimumTrackTintColor":
      return defaultColor.Slider.minimumTrackTintColor
    case "maximumTrackTintColor":
      return defaultColor.Slider.maximumTrackTintColor
    default:
      return .clear
    }
  }
  
  // MARK: Actions
  
  @objc private func paletteTouched(_ sender: UIButton) {
    self.highlightSelectedButton(sender)
    self.delegate?.cell(self, valueForColor: sender.backgroundColor)
    ControlModel.shared.updateValue(sender.tag,
                                    for: self.currentProperty.name,
                                    of: self.currentObject)
  }
  
  private func highlightSelectedButton(_ sender: UIButton) {
    self.colorButtons.forEach {
      $0.transform = $0.tag == sender.tag ? .init(scaleX: 1.3, y: 1.3) : .identity
    }
  }
  
}
