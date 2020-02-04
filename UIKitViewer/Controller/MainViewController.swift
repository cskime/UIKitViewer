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
    print("!1111")
  }
  
  private func setupFlowLayout() {
    flowLayout.itemSize = CGSize(width: 180, height: 180)
    flowLayout.minimumInteritemSpacing = 2
    flowLayout.minimumLineSpacing = 20
    flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    print("@2222")
  }
}
//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("$44")
    return objects.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCellCollectionViewCell.identifier, for: indexPath) as! MainViewCellCollectionViewCell
    cell.backgroundColor = .white
    cell.layer.cornerRadius = cell.frame.width / 3
    cell.configure(title: objects[indexPath.item])
    let item = objects[indexPath.item]
    cell.backgroundColor = .blue
    return cell
    
  }
  
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let object = ClassList(rawValue: objects[indexPath.item]) else { return }
    let operationVC = OperationViewController()
    Manager.shared.object = object
    navigationController?.pushViewController(operationVC, animated: true)
  }
}
