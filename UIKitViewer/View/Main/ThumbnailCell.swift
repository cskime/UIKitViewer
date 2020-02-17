//
//  MainViewCellCollectionViewCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
  static let identifier = String(describing: ThumbnailCell.self)
  
  private let view = UIView()
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLabels()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupLabels() {
    clipsToBounds = true
    layer.cornerRadius = 16
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    contentView.addSubview(imageView)
    
    titleLabel.textAlignment = .center
    titleLabel.backgroundColor = .white
    titleLabel.layer.borderColor = #colorLiteral(red: 0.8999999762, green: 0.8999999762, blue: 0.8999999762, alpha: 1)
    titleLabel.layer.borderWidth = 1
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.1
    contentView.addSubview(titleLabel)
    
    
    self.layer.borderWidth = 0.8
    self.layer.cornerRadius = 8
    self.layer.borderColor = #colorLiteral(red: 0.9044573903, green: 0.9044573903, blue: 0.9044573903, alpha: 1)
  }
  
  private func setupConstraints() {
    [imageView, titleLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    NSLayoutConstraint.activate([
      
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 40)
      
    ])
  }
  func configure(title: String) {
    titleLabel.text = title
    imageView.image = UIImage(named: title)
  }
}
