//
//  BaseCollectionViewCell.swift
//  UIKitViewer
//
//  Created by Chamsol Kim on 2022/08/27.
//  Copyright © 2022 cskim. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAttributes()
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up
    
    func setUpAttributes() {
        
    }
    
    func setUpSubviews() {
        
    }
    
    func setUpConstraints() {
        
    }
}
