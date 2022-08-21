//
//  ObjectPreviewCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import SnapKit
import Then

final class ObjectPreviewCell: UICollectionViewCell {
    
    // MARK: Interface
    
    func configure(with object: UIKitObject) {
        titleLabel.text = object.rawValue
        drawPreview(object)
    }
    
    private func drawPreview(_ object: UIKitObject) {
        guard let previewObject = object.makeInstance() else { return }
        previewObject.tag = Constant.previewObjectTag
        previewObject.isUserInteractionEnabled = false
        contentView.addSubview(previewObject)
        
        switch object {
        case .UISegmentedControl, .UISwitch, .UIStepper, .UIButton, .UILabel:
            constraintToCenter(previewObject)
            
        case .UIActivityIndicatorView:
            guard let activityIndicator = previewObject as? UIActivityIndicatorView else { return }
            activityIndicator.hidesWhenStopped = false
            activityIndicator.style = .large
            constraintToCenter(activityIndicator)
            
        case .UICollectionView:
            constraintToFit(previewObject)
            guard let collectionView = previewObject as? UICollectionView else { return }
            collectionView.backgroundColor = .clear
            collectionView.register(UICollectionViewCell.self)
            collectionView.dataSource = self
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = Metric.itemSize
            layout.sectionInset = Metric.sectionInsets
            layout.minimumLineSpacing = Metric.lineSpacing
            layout.minimumInteritemSpacing = Metric.itemSpacing
            collectionView.collectionViewLayout = layout
            
        case .UITextField, .UISlider:
            constraintToCenter(previewObject)
            previewObject.snp.makeConstraints {
                $0.width.equalTo(contentView.snp.width).dividedBy(2)
            }
            
        case .UIImageView:
            constraintToFit(previewObject)
            guard let imageView = previewObject as? UIImageView else { return }
            imageView.contentMode = .scaleAspectFit
            imageView.image = ImageReference.dummy
            
        case .UIDatePicker:
            guard let picker = previewObject as? UIDatePicker else { return }
            picker.transform = .init(scaleX: 0.5, y: 0.5)
            constraintToCenter(picker)
            
        default:
            constraintToFit(previewObject)
        }
        
        setupAttributes(object: previewObject)
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
        } else if let slider = object as? UISlider {
            slider.value = 0.4
        }
    }
    
    // MARK: - Components
    
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
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAttributes()
        setUpConstraints()
    }
    
    private func setUpAttributes() {
        clipsToBounds = true
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = ColorReference.borderColor?.cgColor
    }
    
    private func setUpConstraints() {
        contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare For Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
            reset()
    }
    
    private func reset() {
        contentView.subviews
            .filter { $0.tag == Constant.previewObjectTag }
            .forEach {
                $0.removeConstraints($0.constraints)
                $0.removeFromSuperview()
            }
    }
}

// MARK: - UICollectionViewDataSource

extension ObjectPreviewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(UICollectionViewCell.self, indexPath: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

// MARK: - Constants

private extension ObjectPreviewCell {
    
    enum Metric {
        // Preview Collection View
        static let itemSize = CGSize(width: 40, height: 40)
        static let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let itemSpacing: CGFloat = 8
        static let lineSpacing: CGFloat = 8
    }
    
    enum Constant {
        static let previewObjectTag = 100
    }
}