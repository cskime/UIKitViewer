//
//  ViewController.swift
//  UIKitViewer
//
//  Created by cskim on 2020/01/31.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class MainViewController: UIViewController {

  // MARK: Views
  
  private enum UI {
    static let itemSpacing: CGFloat = 10
    static let lineSpacing: CGFloat = 10
  }
  
  private lazy var collectionView = UICollectionView(
    frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = ColorReference.background
    $0.register(ThumbnailCell.self)
    $0.collectionViewLayout.do {
      guard let layout = $0 as? UICollectionViewFlowLayout else { return }
      
      layout.minimumInteritemSpacing = UI.itemSpacing
      layout.minimumLineSpacing = UI.lineSpacing
      
      let inset: CGFloat = 16
      layout.sectionInset = .init(top: inset, left: inset, bottom: inset, right: inset)
      
      let width = (UIScreen.main.bounds.width - UI.itemSpacing - inset * 2) / 2
      let height = width * 0.9
      layout.itemSize = CGSize(width: width, height: height)
    }
  }
  
  // MARK: Model
  
  private let dataSource = MainModel.objects
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: Initialize
  
  private func setupUI() {
    self.setupAttributes()
    self.setupConstraints()
  }
  
  private func setupAttributes() {
    self.view.backgroundColor = .systemBackground
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    self.navigationItem.title = "UIKit Viewer"
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setupConstraints() {
    self.view.addSubview(self.collectionView)
    self.collectionView.snp.makeConstraints {
      $0.edges.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}
//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueCell(ThumbnailCell.self, indexPath: indexPath) else { return UICollectionViewCell() }
    cell.configure(title: self.dataSource[indexPath.item].rawValue)
    return cell
  }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let object = self.dataSource[indexPath.item]
    let operationVC = PropertyControlViewController(object: object)
    navigationController?.pushViewController(operationVC, animated: true)
  }
}
