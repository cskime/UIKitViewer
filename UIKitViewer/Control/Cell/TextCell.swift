//
//  TextCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class TextCell: ControlCell {

  // MARK: Views
  
  private let propertyLabel = PropertyLabel()
  private var currentObject: UIKitObject = .UIView
  private lazy var textField = UITextField().then {
    $0.autocapitalizationType = .none
    $0.autocorrectionType = .no
    $0.borderStyle = .roundedRect
    $0.returnKeyType = .done
    $0.delegate = self
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
    [self.propertyLabel, self.textField].forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: UI.paddingY, right: 0))
    }
//    self.propertyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    self.textField.snp.makeConstraints {
      $0.centerY.equalTo(self.propertyLabel)
      $0.leading.equalTo(self.contentView.snp.centerX)
      .offset(UI.paddingX)
      $0.trailing.equalTo(self.contentView).offset(-UI.paddingX)
    }
  }
  
  // MARK: Interface
  
  override func configure(title: String, from object: UIKitObject) {
    self.propertyLabel.configure(name: title)
    self.currentObject = object
    
    if let text = ObjectManager.shared.values(for: title) as? String {
        self.textField.text = text
    } else {
      switch self.currentObject {
      case .UIButton:
        self.textField.text = "Test Button"
      case .UILabel:
        self.textField.text = "Test Label"
      default:
        break
      }
      ObjectManager.shared.addValue(self.textField.text!, for: title)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK:- UITextFieldDelegate

extension TextCell: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    ObjectManager.shared.updateValue(textField.text!, for: self.propertyLabel.property)
    self.delegate?.cell?(self, valueForTextField: textField.text ?? "")
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

    textField.resignFirstResponder()
    return true
  }
}
