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
            let view = viewType.init()
            view.backgroundColor = .gray
            return view
        case .UILabel:
            guard let labelType = classType as? UILabel.Type else { return nil }
            let label = labelType.init()
            label.text = "Test Label"
            label.font = .systemFont(ofSize: 24)
            return label
        case .UIButton:
            guard let buttonType = classType as? UIButton.Type else { return nil }
            let button = buttonType.init()
            button.setTitle("Test Button", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 24)
            return button
        case .UISwitch:
            guard let switchType = classType as? UISwitch.Type else { return nil }
            let `switch` = switchType.init()
            `switch`.isOn = false
            return `switch`
        case .UIStepper:
            guard let stepperType = classType as? UIStepper.Type else { return nil }
            let stepper = stepperType.init()
            return stepper
        case .UITextField:
            guard let textFieldType = classType as? UITextField.Type else { return nil }
            let textField = textFieldType.init()
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            return textField
        case .UITableView:
            guard let tableViewType = classType as? UITableView.Type else { return nil }
            let tableView = tableViewType.init(frame: .zero, style: .plain)
            return tableView
        case .UICollectionView:
            guard let collectionViewType = classType as? UICollectionView.Type else { return nil }
            let collectionView = collectionViewType.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
            collectionView.backgroundColor = .clear
            return collectionView
        case .UIImageView:
            guard let imageViewType = classType as? UIImageView.Type else { return nil }
            let imageView = imageViewType.init()
            imageView.image = UIImage(named: "UIImageView")
            return imageView
        case .UIPageControl:
            guard let pageControlType = classType as? UIPageControl.Type else { return nil }
            let pageControl = pageControlType.init()
            pageControl.numberOfPages = 3
            pageControl.currentPage = 0
            pageControl.backgroundColor = .gray
            return pageControl
        case .UISegmentedControl:
            guard let segmentedControlType = classType as? UISegmentedControl.Type else { return nil }
            let segmentedControl = segmentedControlType.init(items: ["First", "Second"])
            segmentedControl.selectedSegmentIndex = 0
            return segmentedControl
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
