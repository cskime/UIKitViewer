//
//  SelectCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/06.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class SelectCell: ControlCell {
  
  // MARK: Views
  
  private let propertyLabel = PropertyLabel()
  
  private lazy var selectButton = UIButton().then {
    $0.setTitle("Select Case", for: .normal)
    $0.setTitleColor(ColorReference.subText, for: .normal)
    $0.addTarget(self, action: #selector(selectButtonTouched(_:)), for: .touchUpInside)
  }
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupConstraints()
  }
  
  private struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 20
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    [self.propertyLabel, self.selectButton].forEach { self.contentView.addSubview($0) }
    
    self.propertyLabel.snp.makeConstraints {
      $0.top.leading.bottom
        .equalTo(self.contentView)
        .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: UI.paddingY, right: 0))
    }
    
    self.selectButton.snp.makeConstraints {
      $0.centerY.equalTo(self.propertyLabel)
      $0.trailing.equalTo(self.contentView).offset(-UI.paddingX)
    }
  }
  
  // MARK: Interface
  
  private var cases = [String]()
  
  override func configureContents() {
    let title = self.currentProperty.name
    let object = self.currentObject
    self.propertyLabel.configure(name: title)
  
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
    
    if let selected = ControlModel.shared.value(for: title, of: object) as? String {
      self.selectButton.setTitle(selected, for: .normal)
    } else {
      self.selectButton.setTitle(initialTitle, for: .normal)
      ControlModel.shared.setValue(initialTitle, for: title, of: object)
    }
  }
  
  func configure(selectedValue: String) {
    self.selectButton.setTitle(selectedValue, for: .normal)
    ControlModel.shared.updateValue(selectedValue,
                                    for: self.currentProperty.name,
                                    of: self.currentObject)
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.propertyLabel.property.contains(propertyName)
  }
  
  // MARK: Actions
  
  @objc func selectButtonTouched(_ sender: UIButton) {
    self.delegate?.cell(self, valuesForSelect: self.cases)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
