//
//  HomeThumbnailCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import Then
import SnapKit

final class HomeThumbnailCell: UICollectionViewCell {
    
    // MARK: - Interface
    
    func configure(with name: String) {
        let imageBounds = CGRect(
            origin: .zero,
            size: HomeLayout.itemSize.with {
                $0.height -= HomeLayout.titleHeight
            }
        )
        let image = thumbnailGenerator.generate(for: name, inBounds: imageBounds)
        imageView.image = image
        titleLabel.text = name
    }
    
    
    // MARK: - UI
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.contentMode = .center
    }
    private let titleContainer = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = ColorReference.borderColor?.cgColor
        $0.layer.borderWidth = 1
    }
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .preferredFont(forTextStyle: .headline)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    
    // MARK: - Property
    
    private let thumbnailGenerator = HomeThumbnailGenerator()
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAttributes()
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setUpAttributes() {
        clipsToBounds = true
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = ColorReference.borderColor?.cgColor
    }
    
    private func setUpSubviews() {
        [imageView, titleContainer].forEach(contentView.addSubview(_:))
        titleContainer.addSubview(titleLabel)
    }
    
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        titleContainer.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(HomeLayout.titleHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension HomeThumbnailCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(UICollectionViewCell.self, indexPath: indexPath) ?? UICollectionViewCell()
        cell.backgroundColor = .white
        return cell
    }
}
