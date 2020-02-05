//
//  SliderCell.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit


class SliderCell: UITableViewCell {
  
  static let identifier = String(describing: SliderCell.self)
  
  weak var delegate: ControlCellDelegate?
  
  private var value: Float {
    get { return self.slider.value }
    set { self.valueLabel.text = "\(Int(newValue))" }
  }
  private let valueLabel: UILabel = {
    let countLabel = UILabel()
    countLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    countLabel.text = "0"
    return countLabel
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()
  private let slider = UISlider()
  
  // MARK: Initialize
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  
  private func setupUI() {
    self.slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
    self.slider.minimumValue = 0
    self.slider.maximumValue = 50
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 16
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    let subviews = [self.nameLabel, self.slider, self.valueLabel]
    subviews.forEach {
      self.contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
      
      self.valueLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.valueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
      self.valueLabel.bottomAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
      
      self.slider.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.spacing),
      self.slider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX * 2),
      self.slider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX * 2),
      self.slider.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  
  // MARK: Interface
  
  func configure(title: String) {
    self.nameLabel.text = title
  }
  
  // MARK: Actions
  
  @objc private func sliderChanged(_ sender: UISlider) {
    self.value = sender.value
    delegate?.cell?(self, valueForSlider: sender.value)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
