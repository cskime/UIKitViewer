//
//  ViewController.swift
//  UIKitViewer
//
//  Created by cskim on 2020/01/31.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
      
  let flowLayout = UICollectionViewFlowLayout()
  lazy var collectionView = UICollectionView(
    frame: view.frame , collectionViewLayout: flowLayout
  )
  let objects = properties.keys.sorted()
  
    private enum UI {
      static let itemSpacing: CGFloat = 10.0
      static let lineSpacing: CGFloat = 10.0
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupFlowLayout()
  }
  
  private func setupCollectionView() {
    
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MainViewCellCollectionViewCell.self, forCellWithReuseIdentifier: MainViewCellCollectionViewCell.identifier)
    view.addSubview(collectionView)
    print("11111")
  }
  
  private func setupFlowLayout() {
    flowLayout.itemSize = CGSize(width: collectionView.frame.width / 2 - (UI.itemSpacing * 2.5),
                                 height: 180)
    flowLayout.minimumInteritemSpacing = UI.itemSpacing
    flowLayout.minimumLineSpacing = UI.lineSpacing
    flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    print("22222")
  }
}
//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("44444")
    return objects.count
  }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCellCollectionViewCell.identifier, for: indexPath) as! MainViewCellCollectionViewCell
    cell.layer.cornerRadius = 16
    cell.configure(title: objects[indexPath.item])
    cell.layer.borderWidth = 1
    cell.backgroundColor = #colorLiteral(red: 0.5158689916, green: 0.8727806934, blue: 1, alpha: 1)
    cell.layer.borderColor = #colorLiteral(red: 0.5158689916, green: 0.8727806934, blue: 1, alpha: 1)
    return cell
  }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let object = ClassList(rawValue: objects[indexPath.item]) else { return }
    let operationVC = OperationViewController()
    Manager.shared.object = object
    navigationController?.pushViewController(operationVC, animated: true)
  }
}
