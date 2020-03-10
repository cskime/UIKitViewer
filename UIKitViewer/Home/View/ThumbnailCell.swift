//
//  MainViewCellCollectionViewCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
  
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
  }
  private let titleLabel = UILabel().then {
    $0.backgroundColor = .white
    $0.textAlignment = .center
    $0.layer.borderColor = ColorReference.borderColor?.cgColor
    $0.layer.borderWidth = 1
    $0.font = .preferredFont(forTextStyle: .headline)
    $0.adjustsFontSizeToFitWidth = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupUI() {
    self.clipsToBounds = true
    self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    self.layer.cornerRadius = 16
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 8
    self.layer.borderColor = ColorReference.borderColor?.cgColor
    
    self.setupConstraints()
  }
  
  private func setupConstraints() {
    self.contentView.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(40)
    }
  }
  
  // MARK: Interface
  
  func configure(with object: UIKitObject) {
    titleLabel.text = object.rawValue
    self.drawObjectThumbnail(object)
  }
  
  private func drawObjectThumbnail(_ object: UIKitObject) {
    guard let previewObject = object.makeInstance() else { return }
    previewObject.tag = 100
    previewObject.isUserInteractionEnabled = false
    self.contentView.addSubview(previewObject)
    
    switch object {
    case .UISegmentedControl, .UISwitch, .UIStepper, .UIButton, .UILabel:
      self.constraintToCenter(previewObject)
    case .UICollectionView:
      self.constraintToFit(previewObject)
      guard let collectionView = previewObject as? UICollectionView else { return }
      collectionView.backgroundColor = .clear
      collectionView.register(UICollectionViewCell.self)
      collectionView.dataSource = self
      
      let layout = UICollectionViewFlowLayout()
      layout.itemSize = CGSize(width: 40, height: 40)
      layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
      layout.minimumLineSpacing = 8
      layout.minimumInteritemSpacing = 8
      collectionView.collectionViewLayout = layout
    case .UITextField:
      self.constraintToCenter(previewObject)
      previewObject.snp.makeConstraints {
        $0.width.equalTo(self.contentView.snp.width).dividedBy(2)
      }
    case .UIImageView:
      self.constraintToFit(previewObject)
      guard let imageView = previewObject as? UIImageView else { return }
      imageView.image = ImageReference.ObjectThumbnail.imageView
    default:
      self.constraintToFit(previewObject)
    }
    self.setupAttributes(object: previewObject)
  }
  
  func removeThumbnail() {
    self.contentView.subviews
      .filter { $0.tag == 100 }
      .forEach {
        $0.removeConstraints($0.constraints)
        $0.removeFromSuperview()
    }
  }
  
  private func constraintToFit(_ object: UIView) {
    object.snp.makeConstraints {
      $0.top.leading.trailing
      .equalToSuperview()
      $0.bottom.equalTo(self.titleLabel.snp.top)
    }
  }
  
  private func constraintToCenter(_ object: UIView) {
    object.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-20)
    }
  }
  
  private func setupAttributes(object: UIView) {
    if let label = object as? UILabel {
      label.textAlignment = .center
    } else if let `switch` = object as? UISwitch {
      `switch`.isOn = true
    } else if let textField = object as? UITextField {
      textField.borderStyle = .roundedRect
    }
  }
}

// MARK:- UICollectionViewDataSource

extension ThumbnailCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 9
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(UICollectionViewCell.self, indexPath: indexPath) ?? UICollectionViewCell()
    cell.backgroundColor = .white
    return cell
  }
}
