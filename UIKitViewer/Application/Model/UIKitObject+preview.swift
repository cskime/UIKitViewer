//
//  UIKitObject+preview.swift
//  UIKitViewer
//
//  Created by Chamsol Kim on 2022/08/21.
//  Copyright © 2022 cskim. All rights reserved.
//

import UIKit

extension UIKitObject {
    
    var preview: UIView? {
        switch self {
        case .view:
            guard let view = instantiate() else { return nil }
            view.backgroundColor = .white
            return view
            
        case .button:
            guard let button = instantiate() as? UIButton else { return nil }
            button.setTitle("Button", for: .normal)
            return button
            
        case .label:
            guard let label = instantiate() as? UILabel else { return nil }
            label.text = "Label"
            return label
            
        case .imageView:
            guard let imageView = instantiate() as? UIImageView else { return nil }
            imageView.image = ImageReference.dummy
            return imageView
            
        case .pageControl:
            guard let pageControl = instantiate() as? UIPageControl else { return nil }
            pageControl.numberOfPages = 3
            pageControl.currentPage = 0
            return pageControl
            
        case .segmentedControl:
            return instantiate()
            
        case .`switch`:
            guard let `switch` = instantiate() as? UISwitch else { return nil }
            `switch`.isOn = false
            return `switch`
            
        case .slider:
            return instantiate()
            
        case .stepper:
            return instantiate()
            
        case .textField:
            guard let textField = instantiate() as? UITextField else { return nil }
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            return textField
            
        case .tableView:
            return instantiate()
            
        case .collectionView:
            return instantiate()
            
        case .activityIndicatorView:
            return instantiate()
            
        case .datePicker:
            return instantiate()
        }
    }

}
