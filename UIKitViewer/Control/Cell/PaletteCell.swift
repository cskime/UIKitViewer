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
  
  private let colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 1, green: 0.3927565978, blue: 0, alpha: 1)]
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
    self.colors.forEach { (color) in
      let button = UIButton().then { (button) in
        button.backgroundColor = color
        button.addTarget(self, action: #selector(paletteTouched(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
      }
      self.colorButtons.append(button)
    }
    self.colorButtons.first?.setBackgroundImage(UIImage(named: "ClearColor"), for: .normal)
    self.colorButtons.first?.layer.borderWidth = 0.8
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 20
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    let stackView = UIStackView().then {
      $0.axis = .horizontal
      $0.alignment = .fill
      $0.distribution = .fillEqually
      $0.spacing = 24
    }
    colorButtons.forEach {
      stackView.addArrangedSubview($0)
      $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    [self.propertyLabel, stackView].forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: 0, right: 0))
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(self.propertyLabel.snp.bottom).offset(UI.spacing)
      $0.leading.equalTo(self.propertyLabel).offset(UI.spacing)
      $0.trailing.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: 0, left: 0, bottom: UI.paddingY, right: UI.paddingX))
    }
  }
  
  // MARK: Actions
  
  @objc private func paletteTouched(_ sender: UIButton) {
    self.delegate?.cell?(self, valueForColor: sender.backgroundColor)
  }
  
  // MARK: Interface
  
  override func configure(object: UIKitObject, property: PropertyInfo) {
    self.propertyLabel.configure(name: property.name)
    self.currentObject = object
    self.currentProperty = property
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.propertyLabel.property.contains(propertyName)
  }
  
}
