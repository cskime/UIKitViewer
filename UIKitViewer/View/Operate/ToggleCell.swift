//
//  ToggleCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ToggleCell: UITableViewCell {
  
  static let identifier = String(describing: ToggleCell.self)
  
  weak var delegate: ControlCellDelegate?
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  private let toggleSwitch = UISwitch()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  private func setupUI() {
    self.toggleSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    let subviews = [self.nameLabel, self.toggleSwitch]
    subviews.forEach {
      self.contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
      
      self.toggleSwitch.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.toggleSwitch.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
      self.toggleSwitch.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  // MARK: Interface
  
  func configure(title: String) {
    if let currentState = ObjectManager.shared.values(for: title) as? Bool {
      self.toggleSwitch.isOn = currentState
    } else {
      self.toggleSwitch.isOn = false
      ObjectManager.shared.addValue(self.toggleSwitch.isOn, for: title)
    }
    self.nameLabel.text = title
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
