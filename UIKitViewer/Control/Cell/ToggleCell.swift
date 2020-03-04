//
//  ToggleCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ToggleCell: ControlCell {
  
  // MARK: Views
  
  private let propertyLabel = PropertyLabel()
  private lazy var toggleSwitch = UISwitch().then {
    $0.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
  }

  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  private func setupUI() {
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 20
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    [self.propertyLabel, self.toggleSwitch].forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: UI.paddingY, right: 0))
    }
    
    self.toggleSwitch.snp.makeConstraints {
      $0.trailing.equalTo(self.contentView).offset(-UI.paddingX)
      $0.centerY.equalTo(self.propertyLabel)
    }
  }
  
  // MARK: Interface
  
  override func configure(object: UIKitObject, property: PropertyInfo) {
    let title = property.name
    self.propertyLabel.configure(name: title)
    self.currentObject = object
    self.currentProperty = property
    
    if let currentState = ObjectManager.shared.values(for: title) as? Bool {
      self.toggleSwitch.isOn = currentState
    } else {
      switch self.currentObject {
      case .UICollectionView, .UIView, .UITableView, .UISegmentedControl:
        self.toggleSwitch.isOn = !title.contains("isHidden") || title.contains("clipsToBounds")
      default:
        self.toggleSwitch.isOn = false
      }
      
      ObjectManager.shared.addValue(self.toggleSwitch.isOn, for: title)
    }
  }
  
  // MARK: Actions
  
  @objc private func switchChanged(_ sender: UISwitch) {
    ObjectManager.shared.addValue(sender.isOn, for: self.propertyLabel.property)
    self.delegate?.cell?(self, valueForToggle: sender.isOn)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
