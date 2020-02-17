//
//  SelectCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/06.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class SelectCell: ControlCell {
  
  static let identifier = String(describing: SelectCell.self)
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  private var currentObject: ObjectType = .UIView
  var currentProperty: String { return self.nameLabel.text ?? "" }
  
  private let selectButton: UIButton = {
    let button = UIButton()
    button.setTitle("Select Case", for: .normal)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  private func setupUI() {
    self.selectButton.addTarget(self, action: #selector(selectButtonTouched(_:)), for: .touchUpInside)
    setupConstraints()
  }
  
  private struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    let subviews = [self.nameLabel, self.selectButton]
    subviews.forEach {
      self.contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
      
      self.selectButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.selectButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
      self.selectButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  // MARK: Interface
  
  private var cases = [String]()
  override func configure(title: String, from object: ObjectType) {
    self.nameLabel.text = title
    self.currentObject = object
    
    let initialTitle: String
    switch title {
    case "contentMode":
      initialTitle = UIView.ContentMode.scaleToFill.stringRepresentation
      self.cases = UIView.ContentMode.allCases.map { $0.stringRepresentation }
    case "style":
      initialTitle = UITableView.Style.plain.stringRepresentation
      self.cases = UITableView.Style.allCases.map { $0.stringRepresentation }
    case "borderStyle":
      initialTitle = UITextField.BorderStyle.none.stringRepresentation
      self.cases = UITextField.BorderStyle.allCases.map { $0.stringRepresentation }
    case "clearButtonMode":
      initialTitle = UITextField.ViewMode.never.stringRepresentation
      self.cases = UITextField.ViewMode.allCases.map { $0.stringRepresentation }
    default:
      return
    }
    
    if let selected = ObjectManager.shared.values(for: title) as? String {
      self.selectButton.setTitle(selected, for: .normal)
    } else {
      self.selectButton.setTitle(initialTitle, for: .normal)
      ObjectManager.shared.addValue(initialTitle, for: title)
    }
  }
  
  func configure(selectedValue: String) {
    self.selectButton.setTitle(selectedValue, for: .normal)
    ObjectManager.shared.updateValue(selectedValue, for: self.nameLabel.text!)
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.nameLabel.text!.contains(propertyName)
  }
  
  // MARK: Actions
  
  @objc func selectButtonTouched(_ sender: UIButton) {
    self.delegate?.cell?(self, valueForSelect: self.cases)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
