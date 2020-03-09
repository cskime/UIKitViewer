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
      $0.leading.greaterThanOrEqualTo(self.propertyLabel.snp.trailing).offset(UI.paddingX)
      $0.trailing.equalTo(self.contentView).offset(-UI.paddingX)
      $0.centerY.equalTo(self.propertyLabel)
    }
  }
  
  // MARK: Interface
  
  override func configureContents() {
    let title = self.currentProperty.name
    let object = self.currentObject
    self.propertyLabel.configure(name: title)
    
    if let state = ControlModel.shared.value(for: title, of: object) as? Bool {
      self.toggleSwitch.isOn = state
    } else {
      self.configureDefaultValue(for: title, of: object)
    }
  }
  
  private func configureDefaultValue(for property: String, of object: UIKitObject) {
    if property.contains("clipsToBounds") {
      self.addObserverForDisplay()
      self.requestForDisplay {
        ControlModel.shared.setValue(self.toggleSwitch.isOn, for: property, of: object)
        self.removeObserverForDisplay()
      }
    } else {
      self.toggleSwitch.isOn = false
      ControlModel.shared.setValue(self.toggleSwitch.isOn, for: property, of: object)
    }
  }
  
  // MARK: Actions
  
  @objc private func switchChanged(_ sender: UISwitch) {
    ControlModel.shared.updateValue(sender.isOn,
                                    for: self.currentProperty.name,
                                    of: self.currentObject)
    self.delegate?.cell(self, valueForToggle: sender.isOn)
  }
  
  // MARK: Notification
  
  private var requestCompletion: ()->() = { }
  private func requestForDisplay(completion: @escaping ()->()) {
    NotificationCenter.default.post(name: ControlCell.requestDisplayedObjectNotification,
                                    object: self.currentObject)
    self.requestCompletion = completion
  }
      
  private func addObserverForDisplay() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(responseForDisplay(_:)),
                                           name: self.currentObject.responseDisplayedObjectNotification,
                                           object: nil)
  }
  
  private func removeObserverForDisplay() {
    NotificationCenter.default.removeObserver(self,
                                              name: self.currentObject.responseDisplayedObjectNotification,
                                              object: nil)
  }
  
  @objc private func responseForDisplay(_ noti: Notification) {
    guard let object = noti.object as? UIView else { return }
    self.toggleSwitch.isOn = object.clipsToBounds
    self.requestCompletion()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
