//
//  PropertyLabel.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then

class PropertyLabel: UIStackView {
  
  // MARK: Interface
  
  var property: String {
    return self.propertyName.text ?? ""
  }
  
  var owner: String {
    return self.ownerName.text ?? ""
  }
  
  func configure(name: String) {
    let components = name.components(separatedBy: ".")
    let propertyName = name.contains(".") ? components.last! : components.first!
    let ownerName = name.contains(".") ? components.first! : "self"
    
    self.propertyName.text = propertyName
    self.ownerName.text = ownerName
  }
  
  // MARK: Views
  
  private let propertyName = UILabel().then {
    $0.font = .systemFont(ofSize: 18)
    $0.adjustsFontSizeToFitWidth = true
  }
  
  private let ownerName = UILabel().then {
    $0.font = .systemFont(ofSize: 14)
    $0.textColor = ColorReference.subText
  }
  
  // MARK: Initialize
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupUI()
  }
  
  private func setupUI() {
    [self.ownerName, self.propertyName].forEach {
      self.addArrangedSubview($0)
    }
    
    self.axis = .vertical
    self.alignment = .leading
    self.distribution = .fillProportionally
    self.spacing = 0
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
