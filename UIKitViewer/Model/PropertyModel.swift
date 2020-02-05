//
//  Properties.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

enum ControlType {
    case slider // 수치변화하는 control
    case palette // 색 고르는 control
    case textField //몇 가지 중에 고르는 control
    case toggle // true / false 중에 고르는 control
}

struct Property {
  var name: String
  var controlType: ControlType
}
var properties: [String: [Property]] = [
  "UIButton" : [
    Property(name: "setTitle", controlType: .textField),
    Property(name: "setTitleColor", controlType: .palette),
    Property(name: "image", controlType: .toggle),
    Property(name: "setImage", controlType: .toggle),
    Property(name: "setBackgroundImage", controlType: .toggle)
  ],
  "UILabel" : [
    Property(name: "text", controlType: .textField),
    Property(name: "font", controlType: .textField),
    Property(name: "textColor", controlType: .palette),
    Property(name: "minimumScaleFactor", controlType: .slider),
    Property(name: "numberOfLines", controlType: .slider)
  ],
  "UIView" : [
    Property(name: "contentMode", controlType: .toggle),
    Property(name: "tintColor", controlType: .palette),
    Property(name: "backgroundColor", controlType: .palette),
    Property(name: "clipsToBounds", controlType: .toggle),
    Property(name: "alpha", controlType: .slider),
    Property(name: "isHidden", controlType: .toggle)
    ],
  "UISwitch" : [
    Property(name: "isOn", controlType: .toggle),
    Property(name: "setOn", controlType: .toggle),
    Property(name: "onTintColor", controlType: .palette),
    Property(name: "thumbTintColor", controlType: .palette),
  ],
  "UIStepper" : [
    Property(name: "wraps", controlType: .toggle),
    Property(name: "stepValue", controlType: .slider),
    Property(name: "decrementImage", controlType: .toggle),
    Property(name: "setDecrementImage", controlType: .toggle),
    Property(name: "dividerImage", controlType: .toggle),
    Property(name: "setDividerImage", controlType: .toggle)
  ],
  "UITextField" : [
    Property(name: "font", controlType: .slider),
    Property(name: "attributedText", controlType: .textField),
    Property(name: "textColor", controlType: .palette),
    Property(name: "placeholder", controlType: .textField),
    Property(name: "borderStyle", controlType: .slider),
    Property(name: "clearButtonMode", controlType: .toggle),
    Property(name: "disabledBackground", controlType: .toggle),
  ],
  "UITableView" : [
    Property(name: "style", controlType: .slider),
    Property(name: "rowHeight", controlType: .slider),
    Property(name: "numberOfRows", controlType: .slider),
    Property(name: "backgroundView", controlType: .toggle),
    Property(name: "separatorStyle", controlType: .toggle),
    Property(name: "separatorColor", controlType: .palette),
    Property(name: "numberOfSections", controlType: .slider),
  ],
  "UICollectionView" : [
    Property(name: "numberOfItems", controlType: .slider),
    Property(name: "numberOfSections", controlType: .slider),
    Property(name: "insertItems", controlType: .toggle),
    Property(name: "moveItem", controlType: .toggle),
    Property(name: "deleteItem", controlType: .toggle),
    ],
  "UICollectionViewFlowLayout" : [
    Property(name: "minimumLineSpacing", controlType: .slider),
    Property(name: "minimumInteritemSpacing",controlType: .slider),
    Property(name: "itemSize", controlType: .slider),
    Property(name: "sectionInset", controlType: .slider),
    Property(name: "headerReferenceSize", controlType: .slider),
    Property(name: "footerReferenceSize", controlType: .slider),
    ],
  "UIImageView" : [
    Property(name: "isHighlighted", controlType: .toggle),
    Property(name: "highlightImage", controlType: .slider),
    Property(name: "isUserInteractionEnabled", controlType: .toggle),
    Property(name: "startAnimating", controlType: .toggle),
    Property(name: "stopAnimating", controlType: .toggle),
  ],
  "UIPageControl" : [
    Property(name: "size", controlType: .slider),
    Property(name: "numberOfPages", controlType: .slider),
  ],
  "UISegmentedControl" : [
    Property(name: "setDividerImage", controlType: .toggle),
    Property(name: "numberOfSegment", controlType: .slider),
    Property(name: "removeAllSegment", controlType: .toggle),
  ]
]
