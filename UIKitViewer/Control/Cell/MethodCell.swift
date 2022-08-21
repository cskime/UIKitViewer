//
//  MethodCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/05/18.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class MethodCell: ControlCell {
  // MARK: Views
  
  private let propertyLabel = PropertyLabel()
  private lazy var callButton = UIButton().then {
    $0.setTitle("Call", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    $0.backgroundColor = .link
    $0.layer.cornerRadius = 4
    $0.addTarget(self, action: #selector(callTouched(_:)), for: .touchUpInside)
  }
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupAttributes()
    self.setupConstraints()
  }
  
  private func setupAttributes() {
    self.selectionStyle = .none
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 20
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    self.propertyLabel
      .then { self.contentView.addSubview($0) }
      .snp.makeConstraints {
        $0.top.leading.bottom
          .equalTo(self.contentView)
          .inset(UIEdgeInsets(top: UI.paddingY, left: UI.paddingX, bottom: UI.paddingY, right: 0))
    }
    
    self.callButton
      .then { self.contentView.addSubview($0) }
      .snp.makeConstraints {
        $0.centerY.equalTo(self.propertyLabel)
        $0.trailing.equalTo(self.contentView).offset(-UI.paddingX)
        $0.width.equalTo(60)
    }
  }
  
  // MARK: Action
  
  @objc private func callTouched(_ sender: UIButton) {
    switch self.currentObject {
    case .activityIndicatorView:
      self.delegate?.cellWillCallMethod(self)
    default:
      return
    }
  }
  
  // MARK: Interface
  
  override func configureContents() {
    let property = self.currentProperty.name
    let object = self.currentObject
    self.propertyLabel.configure(name: property)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
