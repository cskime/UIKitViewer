//
//  ComponentGenerator.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

struct ComponentGenerator {
    
    func generate(for object: UIKitObject) -> Component {
        Component(
            name: object.name,
            properties: properties(for: object),
            methods: methods(for: object)
        )
    }
}

private extension ComponentGenerator {
    
    func properties(for object: UIKitObject) -> [Property] {
        switch object {
        case .UIView:
            return [
                Property(name: "contentMode", valueType: .option),
                Property(name: "tintColor", valueType: .color),
                Property(name: "backgroundColor", valueType: .color),
                Property(name: "clipsToBounds", valueType: .boolean),
                Property(name: "alpha", valueType: .continuousNumber),
                Property(name: "isHidden", valueType: .boolean),
                Property(name: "layer.borderWidth", valueType: .continuousNumber),
                Property(name: "layer.borderColor", valueType: .color),
                Property(name: "layer.cornerRadius", valueType: .continuousNumber)
            ]
        case .UIButton:
            return [
                Property(name: "buttonType", valueType: .option),
                Property(name: "setTitle", valueType: .text),
                Property(name: "setTitleColor", valueType: .color),
                Property(name: "setImage", valueType: .boolean),
                Property(name: "setBackgroundImage", valueType: .boolean)
            ]
        case .UILabel:
            return [
                Property(name: "text", valueType: .text),
                Property(name: "textColor", valueType: .color),
                Property(name: "textAlignment", valueType: .option),
                Property(name: "numberOfLines", valueType: .discontinuousNumber),
                Property(name: "lineBreakMode", valueType: .option),
                Property(name: "allowsDefaultTighteningForTruncation", valueType: .boolean),
                Property(name: "adjustsFontSizeToFitWidth", valueType: .boolean),
                Property(name: "minimumScaleFactor", valueType: .continuousNumber),
            ]
        case.UISwitch:
            return [
                Property(name: "isOn", valueType: .boolean),
                Property(name: "setOn", valueType: .boolean),
                Property(name: "onTintColor", valueType: .color),
                Property(name: "thumbTintColor", valueType: .color)
            ]
        case .UISlider:
            return [
                Property(name: "minimumValue", valueType: .discontinuousNumber),
                Property(name: "maximumValue", valueType: .discontinuousNumber),
                Property(name: "minimumValueImage", valueType: .boolean),
                Property(name: "maximumValueImage", valueType: .boolean),
                Property(name: "thumbTintColor", valueType: .color),
                Property(name: "minimumTrackTintColor", valueType: .color),
                Property(name: "maximumTrackTintColor", valueType: .color),
            ]
        case .UIStepper:
            return [
                Property(name: "wraps", valueType: .boolean),
                Property(name: "minimumValue", valueType: .discontinuousNumber),
                Property(name: "maximumValue", valueType: .discontinuousNumber),
                Property(name: "stepValue", valueType: .discontinuousNumber),
                Property(name: "setBackgroundImage", valueType: .boolean),
                Property(name: "setIncrementImage", valueType: .boolean),
                Property(name: "setDecrementImage", valueType: .boolean),
                Property(name: "setDividerImage", valueType: .boolean)
            ]
        case .UITextField:
            return [
                Property(name: "placeholder", valueType: .text),
                Property(name: "textColor", valueType: .color),
                Property(name: "textAlignment", valueType: .option),
                Property(name: "adjustsFontSizeToFitWidth", valueType: .boolean),
                Property(name: "minimumFontSize", valueType: .continuousNumber),
                Property(name: "borderStyle", valueType: .option),
                Property(name: "clearsOnBeginEditing", valueType: .boolean),
                Property(name: "clearButtonMode", valueType: .option),
                Property(name: "leftViewMode", valueType: .option),
                Property(name: "rightViewMode", valueType: .option),
            ]
        case .UITableView:
            return [
                Property(name: "style", valueType: .option),
                Property(name: "separatorStyle", valueType: .option),
                Property(name: "separatorColor", valueType: .color),
                Property(name: "setEditing", valueType: .boolean),
                Property(name: "isEditing", valueType: .boolean),
            ]
        case .UICollectionView:
            return [
                Property(name: "collectionViewLayout.scrollDirection", valueType: .option),
                Property(name: "collectionViewLayout.itemSize", valueType: .continuousNumber),
                Property(name: "collectionViewLayout.minimumLineSpacing", valueType: .continuousNumber),
                Property(name: "collectionViewLayout.minimumInteritemSpacing",valueType: .continuousNumber),
                Property(name: "collectionViewLayout.sectionInset", valueType: .continuousNumber),
                Property(name: "collectionViewLayout.headerReferenceSize", valueType: .continuousNumber),
                Property(name: "collectionViewLayout.footerReferenceSize", valueType: .continuousNumber),
                Property(name: "collectionViewLayout.sectionHeadersPinToVisibleBounds", valueType: .boolean),
                Property(name: "collectionViewLayout.sectionFootersPinToVisibleBounds", valueType: .boolean),
            ]
        case .UIImageView:
            return [
            ]
        case .UIPageControl:
            return [
                Property(name: "currentPage", valueType: .discontinuousNumber),
                Property(name: "numberOfPages", valueType: .discontinuousNumber),
                Property(name: "hidesForSinglePage", valueType: .boolean),
                Property(name: "pageIndicatorTintColor", valueType: .color),
                Property(name: "currentPageIndicatorTintColor", valueType: .color),
            ]
        case .UISegmentedControl:
            return [
            ]
        case .UIActivityIndicatorView:
            return [
                Property(name: "hidesWhenStopped", valueType: .boolean),
                Property(name: "style", valueType: .option),
                Property(name: "color", valueType: .color)
            ]
        case .UIDatePicker:
            return [
                Property(name: "datePickerMode", valueType: .option)
            ]
        }
    }
    
    func methods(for object: UIKitObject) -> [Method] {
        switch object {
        case .UIActivityIndicatorView:
            return [
                Method(name: "startAnimating"),
                Method(name: "stopAnimating")
            ]
        default:
            return []
        }
    }
}
