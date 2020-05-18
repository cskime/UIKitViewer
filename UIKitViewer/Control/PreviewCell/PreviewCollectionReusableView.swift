//
//  PreviewCollectionReusableView.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/09.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class PreviewCollectionHeaderView: UICollectionReusableView {
  private let label = UILabel().then {
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.label)
    self.label.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func setText(_ text: String) {
    self.label.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class PreviewCollectionFooterView: PreviewCollectionHeaderView {
        
}
