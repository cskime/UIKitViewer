//
//  TextCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

  static let identifier = String(describing: TextCell.self)
  
  weak var delegate: ControlCellDelegate?
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  private var currentObject: ObjectType = .UIView
  private let textField: UITextField = {
    let textField = UITextField()
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.borderStyle = .roundedRect
    textField.returnKeyType = .done
    return textField
  }()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  private func setupUI() {
    self.textField.delegate = self
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  
  private func setupConstraints() {
    let subviews = [self.nameLabel, self.textField]
    subviews.forEach {
      self.contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
      
      self.textField.topAnchor.constraint(equalTo: self.nameLabel.topAnchor),
      self.textField.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: UI.paddingX),
      self.textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
      self.textField.bottomAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
    ])
    
    self.nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
  
  // MARK: Interface
  
  func configure(title: String, from object: ObjectType) {
    self.nameLabel.text = title
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
    ObjectManager.shared.updateValue(textField.text!, for: self.nameLabel.text!)
    self.delegate?.cell?(self, valueForTextField: textField.text ?? "")
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
