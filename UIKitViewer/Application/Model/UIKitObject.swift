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
}

// MARK:- Properties

extension UIKitObject {
    var properties: [PropertyInfo] {
        switch self {
        case .view:
            return [
                PropertyInfo(name: "contentMode", controlType: .select),
                PropertyInfo(name: "tintColor", controlType: .palette),
                PropertyInfo(name: "backgroundColor", controlType: .palette),
                PropertyInfo(name: "clipsToBounds", controlType: .toggle),
                PropertyInfo(name: "alpha", controlType: .slider),
                PropertyInfo(name: "isHidden", controlType: .toggle),
                PropertyInfo(name: "layer.borderWidth", controlType: .slider),
                PropertyInfo(name: "layer.borderColor", controlType: .palette),
                PropertyInfo(name: "layer.cornerRadius", controlType: .slider)
            ]
        case .button:
            return [
                PropertyInfo(name: "buttonType", controlType: .select),
                PropertyInfo(name: "setTitle", controlType: .textField),
                PropertyInfo(name: "setTitleColor", controlType: .palette),
                PropertyInfo(name: "setImage", controlType: .toggle),
                PropertyInfo(name: "setBackgroundImage", controlType: .toggle)
            ]
        case .label:
            return [
                PropertyInfo(name: "text", controlType: .textField),
                PropertyInfo(name: "textColor", controlType: .palette),
                PropertyInfo(name: "textAlignment", controlType: .select),
                PropertyInfo(name: "numberOfLines", controlType: .stepper),
                PropertyInfo(name: "lineBreakMode", controlType: .select),
                PropertyInfo(name: "allowsDefaultTighteningForTruncation", controlType: .toggle),
                PropertyInfo(name: "adjustsFontSizeToFitWidth", controlType: .toggle),
                PropertyInfo(name: "minimumScaleFactor", controlType: .slider),
            ]
        case .switch:
            return [
                PropertyInfo(name: "isOn", controlType: .toggle),
                PropertyInfo(name: "setOn", controlType: .toggle),
                PropertyInfo(name: "onTintColor", controlType: .palette),
                PropertyInfo(name: "thumbTintColor", controlType: .palette)
            ]
        case .slider:
            return [
                PropertyInfo(name: "minimumValue", controlType: .stepper),
                PropertyInfo(name: "maximumValue", controlType: .stepper),
                PropertyInfo(name: "minimumValueImage", controlType: .toggle),
                PropertyInfo(name: "maximumValueImage", controlType: .toggle),
                PropertyInfo(name: "thumbTintColor", controlType: .palette),
                PropertyInfo(name: "minimumTrackTintColor", controlType: .palette),
                PropertyInfo(name: "maximumTrackTintColor", controlType: .palette),
            ]
        case .stepper:
            return [
                PropertyInfo(name: "wraps", controlType: .toggle),
                PropertyInfo(name: "minimumValue", controlType: .stepper),
                PropertyInfo(name: "maximumValue", controlType: .stepper),
                PropertyInfo(name: "stepValue", controlType: .stepper),
                PropertyInfo(name: "setBackgroundImage", controlType: .toggle),
                PropertyInfo(name: "setIncrementImage", controlType: .toggle),
                PropertyInfo(name: "setDecrementImage", controlType: .toggle),
                PropertyInfo(name: "setDividerImage", controlType: .toggle)
            ]
        case .textField:
            return [
                PropertyInfo(name: "placeholder", controlType: .textField),
                PropertyInfo(name: "textColor", controlType: .palette),
                PropertyInfo(name: "textAlignment", controlType: .select),
                PropertyInfo(name: "adjustsFontSizeToFitWidth", controlType: .toggle),
                PropertyInfo(name: "minimumFontSize", controlType: .slider),
                PropertyInfo(name: "borderStyle", controlType: .select),
                PropertyInfo(name: "clearsOnBeginEditing", controlType: .toggle),
                PropertyInfo(name: "clearButtonMode", controlType: .select),
                PropertyInfo(name: "leftViewMode", controlType: .select),
                PropertyInfo(name: "rightViewMode", controlType: .select),
            ]
        case .tableView:
            return [
                PropertyInfo(name: "style", controlType: .select),
                PropertyInfo(name: "separatorStyle", controlType: .select),
                PropertyInfo(name: "separatorColor", controlType: .palette),
                PropertyInfo(name: "setEditing", controlType: .toggle),
                PropertyInfo(name: "isEditing", controlType: .toggle),
            ]
        case .collectionView:
            return [
                PropertyInfo(name: "collectionViewLayout.scrollDirection", controlType: .select),
                PropertyInfo(name: "collectionViewLayout.itemSize", controlType: .slider),
                PropertyInfo(name: "collectionViewLayout.minimumLineSpacing", controlType: .slider),
                PropertyInfo(name: "collectionViewLayout.minimumInteritemSpacing",controlType: .slider),
                PropertyInfo(name: "collectionViewLayout.sectionInset", controlType: .slider),
                PropertyInfo(name: "collectionViewLayout.headerReferenceSize", controlType: .slider),
                PropertyInfo(name: "collectionViewLayout.footerReferenceSize", controlType: .slider),
                PropertyInfo(name: "collectionViewLayout.sectionHeadersPinToVisibleBounds", controlType: .toggle),
                PropertyInfo(name: "collectionViewLayout.sectionFootersPinToVisibleBounds", controlType: .toggle),
            ]
        case .imageView:
            return [
            ]
        case .pageControl:
            return [
                PropertyInfo(name: "currentPage", controlType: .stepper),
                PropertyInfo(name: "numberOfPages", controlType: .stepper),
                PropertyInfo(name: "hidesForSinglePage", controlType: .toggle),
                PropertyInfo(name: "pageIndicatorTintColor", controlType: .palette),
                PropertyInfo(name: "currentPageIndicatorTintColor", controlType: .palette),
            ]
        case .segmentedControl:
            return [
            ]
        case .activityIndicatorView:
            return [
                PropertyInfo(name: "startAnimating", controlType: .methodCall),
                PropertyInfo(name: "stopAnimating", controlType: .methodCall),
                PropertyInfo(name: "hidesWhenStopped", controlType: .toggle),
                PropertyInfo(name: "style", controlType: .select),
                PropertyInfo(name: "color", controlType: .palette)
            ]
        case .datePicker:
            var properties = [PropertyInfo]()
            properties.append(PropertyInfo(name: "datePickerMode", controlType: .select))
            //      if #available(iOS 13.4, *) {
            //        properties.append(PropertyInfo(name: "preferredDatePickerStyle", controlType: .select))
            //      }
            return properties
        }
    }
}


// MARK:- Instantiate

extension UIKitObject {
    
    func makeInstance() -> UIView? {
        guard let classType = NSClassFromString(self.rawValue) else { return nil }
        switch self {
        case .view:
            guard let viewType = classType as? UIView.Type else { return nil }
            let view = viewType.init()
            return view
        case .label:
            guard let labelType = classType as? UILabel.Type else { return nil }
            let label = labelType.init()
            label.text = "Label"
            return label
        case .button:
            guard let buttonType = classType as? UIButton.Type else { return nil }
            let button = buttonType.init(type: .system)
            button.setTitle("Button", for: .normal)
            return button
        case .switch:
            guard let switchType = classType as? UISwitch.Type else { return nil }
            let `switch` = switchType.init()
            `switch`.isOn = false
            return `switch`
        case .slider:
            guard let sliderType = classType as? UISlider.Type else { return nil }
            let slider = sliderType.init()
            return slider
        case .stepper:
            guard let stepperType = classType as? UIStepper.Type else { return nil }
            let stepper = stepperType.init()
            return stepper
        case .textField:
            guard let textFieldType = classType as? UITextField.Type else { return nil }
            let textField = textFieldType.init()
            textField.returnKeyType = .done
            textField.becomeFirstResponder()
            return textField
        case .tableView:
            guard let tableViewType = classType as? UITableView.Type else { return nil }
            return tableViewType.init(frame: .zero, style: .plain)
        case .collectionView:
            guard let collectionViewType = classType as? UICollectionView.Type else { return nil }
            return collectionViewType.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        case .imageView:
            guard let imageViewType = classType as? UIImageView.Type else { return nil }
            let imageView = imageViewType.init()
            imageView.image = ImageReference.dummy
            return imageView
        case .pageControl:
            guard let pageControlType = classType as? UIPageControl.Type else { return nil }
            let pageControl = pageControlType.init()
            pageControl.numberOfPages = 3
            pageControl.currentPage = 0
            return pageControl
        case .segmentedControl:
            guard let segmentedControlType = classType as? UISegmentedControl.Type else { return nil }
            let segmentedControl = segmentedControlType.init(items: ["First", "Second"])
            segmentedControl.selectedSegmentIndex = 0
            return segmentedControl
        case .activityIndicatorView:
            guard let activityIndicatorType = classType as? UIActivityIndicatorView.Type else { return nil }
            let activityIndicator = activityIndicatorType.init()
            return activityIndicator
        case .datePicker:
            guard let datePickerType = classType as? UIDatePicker.Type else { return nil }
            let datePicker = datePickerType.init()
            return datePicker
        }
    }
}
