//
//  UIKitObjects.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

enum UIKitObject: String, CaseIterable, Hashable {
    case view = "UIView"
    case button = "UIButton"
    case label = "UILabel"
    case imageView = "UIImageView"
    case pageControl = "UIPageControl"
    case segmentedControl = "UISegmentedControl"
    case `switch` = "UISwitch"
    case slider = "UISlider"
    case stepper = "UIStepper"
    case textField = "UITextField"
    case tableView = "UITableView"
    case collectionView = "UICollectionView"
    case activityIndicatorView = "UIActivityIndicatorView"
    case datePicker = "UIDatePicker"
    
    var objectsWithinInheritance: [UIKitObject] {
        guard var currentType = NSClassFromString(rawValue) as? UIView.Type else {
            return []
        }
        
        var objects = [self]
        guard self != .view else {
            return objects
        }
        
        while let superType = currentType.superclass() as? UIView.Type {
            let stringObject = String(describing: type(of: superType.init()))
            guard let object = UIKitObject(rawValue: stringObject) else {
                currentType = superType
                continue
            }
            
            objects.append(object)
            
            guard object != .view else {
                break
            }
            currentType = superType
        }
        
        return objects
    }
    
    func instantiate() -> UIView? {
        switch self {
        case .view:                     return UIView()
        case .button:                   return UIButton(type: .system)
        case .label:                    return UILabel()
        case .imageView:                return UIImageView()
        case .pageControl:              return UIPageControl()
        case .segmentedControl:         return UISegmentedControl(items: ["First", "Second"])
        case .switch:                   return UISwitch()
        case .slider:                   return UISlider()
        case .stepper:                  return UIStepper()
        case .textField:                return UITextField()
        case .tableView:                return UITableView(frame: .zero, style: .plain)
        case .collectionView:           return UICollectionView(frame: .zero,
                                                                collectionViewLayout: UICollectionViewFlowLayout())
        case .activityIndicatorView:    return UIActivityIndicatorView()
        case .datePicker:               return UIDatePicker()
        }
    }
}
