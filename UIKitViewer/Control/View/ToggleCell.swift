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
  
  private let nameLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16)
  }
  private lazy var toggleSwitch = UISwitch().then {
    $0.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
  }
  
  // MARK: Properties
  
  private var currentObject: UIKitObject = .UIView
  
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
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    [self.nameLabel, self.toggleSwitch].forEach { self.contentView.addSubview($0) }
    
    self.nameLabel.snp.makeConstraints {
      $0.top.leading.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: UI.paddingY, right: 0))
    }
    
    self.toggleSwitch.snp.makeConstraints {
      $0.top.trailing.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: 0, bottom: UI.paddingY, right: UI.paddingX))
    }
  }
  
  // MARK: Interface
  
  override func configure(title: String, from object: UIKitObject) {
    self.nameLabel.text = title
    self.currentObject = object
    
    if let currentState = ObjectManager.shared.values(for: title) as? Bool {
      self.toggleSwitch.isOn = currentState
    } else {
      switch self.currentObject {
      case .UICollectionView, .UIView, .UITableView, .UISegmentedControl:
        self.toggleSwitch.isOn = !self.relates(to: "isHidden") || self.relates(to: "clipsToBounds")
      default:
        self.toggleSwitch.isOn = false
      }
      
      ObjectManager.shared.addValue(self.toggleSwitch.isOn, for: title)
    }
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.nameLabel.text!.contains(propertyName)
  }
  
  // MARK: Actions
  
  @objc private func switchChanged(_ sender: UISwitch) {
    ObjectManager.shared.addValue(sender.isOn, for: self.nameLabel.text!)
    self.delegate?.cell?(self, valueForToggle: sender.isOn)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
