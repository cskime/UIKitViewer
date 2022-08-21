//
//  ObjectListViewController.swift
//  UIKitViewer
//
//  Created by cskim on 2020/01/31.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class ObjectListViewController: UIViewController {
    
    // MARK: Components
    
    private lazy var collectionView = UICollectionView(
        frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = ColorReference.background
        $0.register(ObjectPreviewCell.self)
        $0.collectionViewLayout
            .cast(to: UICollectionViewFlowLayout.self)?
            .do {
                $0.minimumInteritemSpacing = Metric.itemSpacing
                $0.minimumLineSpacing = Metric.lineSpacing
                $0.sectionInset = Metric.sectionInsets
                $0.itemSize = Metric.itemSize
            }
    }
    
    // MARK: Attributes
    
    private let dataSource = UIKitObject.allCases
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        setupConstraints()
    }
    
    private func setupAttributes() {
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.title = Text.title
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ObjectListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ObjectPreviewCell.self, indexPath: indexPath)
        cell.configure(with: dataSource[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ObjectListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = dataSource[indexPath.item]
        let propertyControlViewController = PropertyControlViewController(object: object)
        navigationController?.pushViewController(propertyControlViewController, animated: true)
    }
}

// MARK: - Constants

private extension ObjectListViewController {
    
    enum Metric {
        static let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let itemSpacing: CGFloat = 16
        static let lineSpacing: CGFloat = 16
        static var itemSize: CGSize {
            let length = (UIScreen.main.bounds.width - Metric.itemSpacing - sectionInsets.left * 2) / 2
            return CGSize(width: length, height: length)
        }
    }
    
    enum Text {
        static let title = "UIKit"
    }
}
