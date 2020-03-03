//
//  DisplayView.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/05.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import SnapKit
import Then

class DisplayView: UIView {
  
  private var previewObject = UIView()
  private var previewType: UIKitObject = .UIView
  
  // MARK: Initialize
  
  init(objectType: UIKitObject) {
    super.init(frame: .zero)
    self.previewType = objectType
    self.setupUI()
  }
  
  private func setupUI() {
    self.setupAttributes()
    self.setupObject()
    self.setupConstraint()
  }
  
  private func setupAttributes() {
    self.layer.cornerRadius = 8
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.backgroundColor = .white
    self.clipsToBounds = true
  }
  
  private func setupObject() {
    self.previewObject = self.previewType.makeInstance() ?? UIView()
    
    switch self.previewType {
    case .UITextField:
      guard let textField = self.previewObject as? UITextField else { return }
      textField.delegate = self
    case .UITableView:
      guard let tableView = self.previewObject as? UITableView else { return }
      tableView.dataSource = self
      tableView.delegate = self
    case .UICollectionView:
      guard let collectionView = self.previewObject as? UICollectionView else { return }
      collectionView.dataSource = self
      collectionView.delegate = self
    default:
      return
    }
  }
  
  private func setupConstraint() {
    self.addSubview(self.previewObject)
    self.previewObject.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    self.previewObject.snp.makeConstraints { [weak self] in
      guard let self = self else { return }
      
      switch self.previewType {
      case .UILabel, .UIButton:
        $0.width.lessThanOrEqualToSuperview().dividedBy(2)
      case .UITextField:
        $0.width.equalToSuperview().dividedBy(2)
      case .UIImageView, .UIView, .UITableView, .UICollectionView:
        $0.size.equalToSuperview().multipliedBy(0.9)
      default:
        return
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

// MARK:- Interfaces - TextField

extension DisplayView {
  
  func configure(title: String) {
    switch self.previewType {
    case .UIButton:
      guard let button = self.previewObject as? UIButton else { return }
      button.setTitle(title, for: .normal)
    case .UILabel:
      guard let label = self.previewObject as? UILabel else { return }
      label.text = title
    case .UITextField:
      guard let textField = self.previewObject as? UITextField else { return }
      textField.text = title
    default:
      return
    }
  }
}

// MARK:- Interfaces - Palette

extension DisplayView {
  
  enum SwitchColorType {
    case onTint, thumbTint
  }
  func configureSwitch(color: UIColor?, for type: SwitchColorType) {
    guard let `switch` = self.previewObject as? UISwitch else { return }
    switch type {
    case .onTint:
      `switch`.onTintColor = color
    case .thumbTint:
      `switch`.thumbTintColor = color
    }
    
  }
  
  func configure(textColor color: UIColor?) {
    switch self.previewType {
    case .UIButton:
      guard let button = self.previewObject as? UIButton else { return }
      button.setTitleColor(color, for: .normal)
    case .UILabel:
      guard let label = self.previewObject as? UILabel else { return }
      label.textColor = color
    case .UITextField:
      guard let textField = self.previewObject as? UITextField else { return }
      textField.textColor = color
    default:
      return
    }
  }
  
  func configureTableView(separatorColor color: UIColor?) {
    guard let tableView = self.previewObject as? UITableView else { return }
    tableView.separatorColor = color
  }
  
  func configure(backgroundColor color: UIColor?) { self.previewObject.backgroundColor = color }
  func configure(tintColor color: UIColor?) { self.previewObject.tintColor = color }
  func configure(borderColor color: UIColor?) { self.previewObject.layer.borderColor = color?.cgColor }
}

// MARK:- Interfaces - Toggle

extension DisplayView {
  
  func configureTextField(shouldDisplayPlaceholder display: Bool) {
    guard let textField = self.previewObject as? UITextField else { return }
    textField.placeholder = display ? "placeholder" : ""
  }
  
  enum ImageType {
    case `default`      // 설정할 이미지 1개일 때 이미지
    case background     // 밑바닥에 깔리는 이미지
    case increment, decrement, divider      // UIStepper image
  }
  
  func configure(shouldSetImage: Bool, for type: ImageType) {
    switch self.previewType {
    case .UIButton:
      guard let button = self.previewObject as? UIButton else { return }
      switch type {
      case .default:
        button.setImage(shouldSetImage ? UIImage(named: "UIImageView") : nil, for: .normal)
      case .background:
        button.setBackgroundImage(shouldSetImage ? UIImage(named: "UIImageView") : nil, for: .normal)
      default:
        return
      }
    case .UIStepper:
      guard let stepper = self.previewObject as? UIStepper else { return }
      switch type {
      case .increment:
        stepper.setIncrementImage(shouldSetImage ? UIImage(named: "UIImageView") : nil, for: .normal)
      case .decrement:
        stepper.setDecrementImage(shouldSetImage ? UIImage(named: "UIImageView") : nil, for: .normal)
      case .divider:
        stepper.setDividerImage(shouldSetImage ? UIImage(named: "UIImageView") : nil,
                                forLeftSegmentState: .normal,
                                rightSegmentState: .normal)
      case .background:
        stepper.setBackgroundImage(shouldSetImage ? UIImage(named: "UIImageView") : nil, for: .normal)
      default:
        return
      }
    default:
      return
    }
  }
  
  func configure(isOn value: Bool) {
    guard let `switch` = self.previewObject as? UISwitch else { return }
    `switch`.isOn = value
  }
  
  func configure(setOn value: Bool) {
    guard let `switch` = self.previewObject as? UISwitch else { return }
    `switch`.setOn(value , animated: true)
  }
  
  func configure(hidden value: Bool) { self.previewObject.isHidden = value }
  func configure(clipsToBounds value: Bool) { self.previewObject.clipsToBounds = value }
  
}

// MARK:- Interfaces - Slider

extension DisplayView {
  
  func configureLabel(numberOfLines value: Float) {
    guard let label = self.previewObject as? UILabel else { return }
    label.numberOfLines = Int(value)
  }
  
  enum CollectionViewLayoutType {
    case itemSize, lineSpacing, itemSpacing, sectionInset
    case headerSize, footerSize
  }
  func configureCollectionViewLayout(with value: Float, for type: CollectionViewLayoutType) {
    guard
      let collectionView = self.previewObject as? UICollectionView,
      let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
      else { return }
    
    let layoutValue = CGFloat(value)
    switch type {
    case .itemSize:
      layout.itemSize = CGSize(width: layoutValue, height: layoutValue)
    case .itemSpacing:
      layout.minimumInteritemSpacing = layoutValue
    case .lineSpacing:
      layout.minimumLineSpacing = layoutValue
    case .sectionInset:
      layout.sectionInset = UIEdgeInsets(
        top: layoutValue, left: layoutValue, bottom: layoutValue, right: layoutValue
      )
    default:
      return
    }
  }
  
  enum PageContrlValueType {
    case numberOfPages, currentPage
  }
  func configurePageControl(with value: Float, for type: PageContrlValueType) {
    guard let pageControl = self.previewObject as? UIPageControl else { return }
    
    let value = Int(value)
    switch type {
    case .currentPage:
      pageControl.currentPage = value
    case .numberOfPages:
      pageControl.numberOfPages = value
    }
  }
  
  func configure(alpha value: Float) { self.previewObject.alpha = CGFloat(value) }
  func configure(borderWidth value: Float) { self.previewObject.layer.borderWidth = CGFloat(value) }
  func configure(cornerRadius value: Float) { self.previewObject.layer.cornerRadius = CGFloat(value) }
  
}

// MARK:- Interfaces - Select

extension DisplayView {
  func configure(contentMode mode: UIView.ContentMode) { self.previewObject.contentMode = mode }
  
  func configure(tableViewStyle style: UITableView.Style) {
    self.replaceTableViewStyle(to: style)
  }
  
  private func replaceTableViewStyle(to style: UITableView.Style) {
    self.previewObject.removeConstraints(self.previewObject.constraints)
    self.previewObject.removeFromSuperview()
    
    let tableView = UITableView(frame: .zero, style: style).then {
      $0.dataSource = self
      $0.delegate = self
    }
    self.previewObject = tableView
    
    self.addSubview(self.previewObject)
    self.previewObject.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalToSuperview().multipliedBy(0.9)
    }
  }
  
  func configure(textFieldBorderStyle style: UITextField.BorderStyle) {
    guard let textField = self.previewObject as? UITextField else { return }
    textField.borderStyle = style
  }
  
  func configure(clearButtonMode mode: UITextField.ViewMode) {
    guard let textField = self.previewObject as? UITextField else { return }
    textField.clearButtonMode = mode
  }
}

// MARK:- UITableViewDataSource

extension DisplayView: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Section \(section)"
  }
  
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return nil
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell()
    cell.textLabel?.text = "Section : \(indexPath.section), Row: \(indexPath.row)"
    //    cell.textLabel?.font = .systemFont(ofSize: 12)
    return cell
  }
  
}

// MARK:- UITableViewDelegate

extension DisplayView: UITableViewDelegate {
  
}

// MARK:- UICollectionViewDataSource

extension DisplayView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  var colorsForItem: UIColor? {
    get {
      let colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
      return colors.randomElement()
    }
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    cell.backgroundColor = self.colorsForItem
    return cell
  }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension DisplayView: UICollectionViewDelegateFlowLayout {
  
}

// MARK:- UITextFieldDelegate

extension DisplayView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
