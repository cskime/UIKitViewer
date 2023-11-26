//
//  HomeViewController.swift
//  UIKitViewer
//
//  Created by cskim on 2020/01/31.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var collectionView = UICollectionView(
        frame: view.frame,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = ColorReference.background
        $0.register(HomeThumbnailCell.self)
        $0.collectionViewLayout.do {
            guard let layout = $0 as? UICollectionViewFlowLayout else {
                return
            }
            
            layout.minimumInteritemSpacing = Metric.itemSpacing
            layout.minimumLineSpacing = Metric.lineSpacing
            layout.sectionInset = Metric.sectionInset
            layout.itemSize = Metric.itemSize
        }
    }
    
    
    // MARK: - Property
    
    private let controller: HomeControllerProtocol
    private var viewModels = [HomeViewModel]()
    private let dataSource = UIKitObject.allCases
    
    
    // MARK: - Initializer
    
    init(controller: HomeController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAttributes()
        setUpSubviews()
        setUpConstraints()
    }
    
    
    // MARK: - Setup
    
    private func setUpAttributes() {
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.title = "UIKit"
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setUpSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueCell(HomeThumbnailCell.self, indexPath: indexPath) ?? UICollectionViewCell()
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = dataSource[indexPath.item]
        let operationVC = PropertyControlViewController(object: object)
        navigationController?.pushViewController(operationVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? HomeThumbnailCell else { return }
        cell.configure(with: dataSource[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? HomeThumbnailCell else { return }
        cell.removeThumbnail()
    }
}


// MARK: - Constant

private extension HomeViewController {
    
    enum Metric {
        static let itemSpacing: CGFloat = 10
        static let lineSpacing: CGFloat = 10
        static let sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static var itemSize: CGSize {
            let inset: CGFloat = 16
            let width = (UIScreen.main.bounds.width - itemSpacing - inset * 2) / 2
            let height = width * 0.9
            return CGSize(width: width, height: height)
        }
    }
}
