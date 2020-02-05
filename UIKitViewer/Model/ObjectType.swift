//
//  ClassModel.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

struct ObjectInfo {
    var name: String
    var properties: [Property]
}

enum ObjectType: String {
    case UIView
    case UIButton
    case UILabel
    case UISwitch
    case UIStepper
    case UITextField
    case UITableView
    case UICollectionView
    case UIImageView
    case UIPageControl
    case UISegmentedControl

    
    func getInstance() -> UIView? {
        guard let classType = NSClassFromString(self.rawValue) else { return nil }
        switch self {
        case .UIView:
            guard let viewType = classType as? UIView.Type else { return nil }
            return viewType.init()
        case .UILabel:
            guard let labelType = classType as? UILabel.Type else { return nil }
            return labelType.init()
        case .UIButton:
            guard let buttonType = classType as? UIButton.Type else { return nil }
            return buttonType.init()
        case .UISwitch:
            guard let switchType = classType as? UISwitch.Type else { return nil }
            return switchType.init()
        case .UIStepper:
            guard let stepperType = classType as? UIStepper.Type else { return nil }
            return stepperType.init()
        case .UITextField:
            guard let textFieldType = classType as? UITextField.Type else { return nil }
            return textFieldType.init()
        case .UITableView:
            guard let tableViewType = classType as? UITableView.Type else { return nil }
            return tableViewType.init()
        case .UICollectionView:
            guard let collectionViewType = classType as? UICollectionView.Type else { return nil }
            return collectionViewType.init()
        case .UIImageView:
            guard let imageViewType = classType as? UIImageView.Type else { return nil }
            return imageViewType.init()
        case .UIPageControl:
            guard let pageControlType = classType as? UIPageControl.Type else { return nil }
            return pageControlType.init()
        case .UISegmentedControl:
            guard let segmentedControlType = classType as? UISegmentedControl.Type else { return nil }
            return segmentedControlType.init()
        }
    }
    func getClass() -> AnyClass? {
        return NSClassFromString(self.rawValue)
    }
    
    func classNamesWithinInheritance() -> [String] {
        guard var current = self.getClass() else { return [] }
        var objects = [String(describing: current)]
        guard objects.first != "UIView" else { return objects }
        
        while let superClass = current.superclass() {
            let className = String(describing: superClass)
            objects.append(className)
            if className == "UIView" { return objects }
            else { current = superClass }
        }
        
        return objects
    }
}
