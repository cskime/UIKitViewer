//
//  DisplayVIew.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class DisplayView: UIView {
  
  private var object = UIView()
  private var objectType: ObjectType = .UIView
  
  // MARK: Initialize
  
  init(objectType: ObjectType) {
    super.init(frame: .zero)
    self.objectType = objectType
    self.setupUI()
  }
  
  private func setupUI() {
    self.setupAttributes()
    self.setupObject()
  }
  
  private func setupAttributes() {
    self.layer.cornerRadius = 16
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.backgroundColor = .white
  }
  
  private func setupObject() {
    
    var willLayoutView = false
    var willLayoutTextField = false
    switch self.objectType {
    case .UIView:
      object = UIView()
      object.backgroundColor = .black
      willLayoutView = true
    case .UIButton:
      guard let button = self.objectType.getInstance() as? UIButton else { return }
      button.setTitle("Test Button", for: .normal)
      button.setTitleColor(.black, for: .normal)
      object = button
    case .UILabel:
      guard let label = self.objectType.getInstance() as? UILabel else { return }
      label.text = "Test Label"
      object = label
    case .UIStepper:
      guard let stepper = self.objectType.getInstance() as? UIStepper else { return }
      object = stepper
    case .UITextField:
      guard let textField = self.objectType.getInstance() as? UITextField else { return }
      textField.borderStyle = .roundedRect
      object = textField
      willLayoutTextField = true
    case .UISwitch:
      guard let `switch` = self.objectType.getInstance() as? UISwitch else { return }
      `switch`.isOn = true
      object = `switch`
    default:
      object = UIView()
    }
    
    object.isUserInteractionEnabled = false
    self.addSubview(object)
    object.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      object.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      object.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    ])
    
    if willLayoutView {
      NSLayoutConstraint.activate([
        object.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
        object.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
      ])
    }
    
    if willLayoutTextField {
      NSLayoutConstraint.activate([
        object.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
      ])
    }
    
  }
  
  // MARK: Interface
  
  func configure(title: String) {
    switch self.objectType {
    case .UIButton:
      guard let button = self.object as? UIButton else { return }
      button.setTitle(title, for: .normal)
    case .UILabel:
      guard let label = self.object as? UILabel else { return }
      label.text = title
    default:
      return
    }
  }
  
  func configure(backgroundColor color: UIColor?) {
    self.object.backgroundColor = color
  }
  
  func configure(tintColor color: UIColor?) {
    self.object.tintColor = color
  }
  
  func configure(textColor color: UIColor?) {
    switch self.objectType {
    case .UIButton:
      guard let button = self.object as? UIButton else { return }
      button.setTitleColor(color, for: .normal)
    case .UILabel:
      guard let label = self.object as? UILabel else { return }
      label.textColor = color
    default:
      return
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
