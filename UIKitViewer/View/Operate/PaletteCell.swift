//
//  PaletteCellTableViewCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class PaletteCell: UITableViewCell {
  
  static let identifier = String(describing: PaletteCell.self)
  
  weak var delegate: ControlCellDelegate?
  
  private let colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 1, green: 0.3927565978, blue: 0, alpha: 1)]
  private var colorButtons = [UIButton]()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  private var currentObject: ObjectType = .UIView
  
  // MARK: Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupUI()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Initialze
  
  private func setupUI() {
    colors.forEach {
      let button = UIButton()
      button.backgroundColor = $0
      button.addTarget(self, action: #selector(paletteTouched(_:)), for: .touchUpInside)
      button.layer.cornerRadius = 8
      button.clipsToBounds = true
      self.colorButtons.append(button)
    }
    self.colorButtons.first?.setBackgroundImage(UIImage(named: "ClearColor"), for: .normal)
    self.colorButtons.first?.layer.borderWidth = 0.8
    self.setupConstraints()
  }
  
  struct UI {
    static let paddingY: CGFloat = 8
    static let paddingX: CGFloat = 16
    static let spacing: CGFloat = 8
  }
  private func setupConstraints() {
    let stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .horizontal
      stackView.alignment = .fill
      stackView.distribution = .fillEqually
      stackView.spacing = 16
      return stackView
    }()
    colorButtons.forEach {
      stackView.addArrangedSubview($0)
      $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    let subviews = [self.nameLabel, stackView]
    subviews.forEach { self.contentView.addSubview($0) }
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
      self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
    ])
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.spacing),
      stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX * 3),
      stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX * 3),
      stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
    ])
  }
  
  // MARK: Actions
  
  @objc private func paletteTouched(_ sender: UIButton) {
    self.delegate?.cell?(self, valueForColor: sender.backgroundColor)
  }
  
  // MARK: Interface
  
  func configure(title: String, from object: ObjectType) {
    self.nameLabel.text = title
    self.currentObject = object
  }
  
  func relates(to propertyName: String) -> Bool {
    return self.nameLabel.text!.contains(propertyName)
  }
  
}
