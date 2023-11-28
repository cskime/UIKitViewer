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
    
    // MARK: - Interface
    
    var controller: HomeControllerProtocol?
    
    
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
            
            layout.minimumInteritemSpacing = HomeLayout.itemSpacing
            layout.minimumLineSpacing = HomeLayout.lineSpacing
            layout.sectionInset = HomeLayout.sectionInset
            layout.itemSize = HomeLayout.itemSize
        }
    }
    
    
    // MARK: - Property
    
    private var viewModel = HomeViewModel() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // TODO: Replace to HomeViewModel
    // It's unavailable due to detail view(PropertyControlViewController)
    private let dataSource = UIKitObject.allCases
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
        setUpSubviews()
        setUpConstraints()
        
        controller?.initialize()
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


// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    
    func display(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}


// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.components.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(HomeThumbnailCell.self, indexPath: indexPath)
        cell?.configure(with: viewModel.components[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = dataSource[indexPath.item]
        let operationVC = PropertyControlViewController(object: object)
        navigationController?.pushViewController(operationVC, animated: true)
    }
}
