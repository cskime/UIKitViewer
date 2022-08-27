//
//  PropertyInfo.swift
//  UIKitViewer
//
//  Created by Chamsol Kim on 2022/08/21.
//  Copyright © 2022 cskim. All rights reserved.
//

import Foundation

struct PropertyInfo {
    var name: String
    var controlType: ControlType
}

// MARK: - UIKitObject Priperties

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
