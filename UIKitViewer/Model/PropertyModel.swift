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
    Property(name: "setImage", controlType: .toggle),
    Property(name: "setTitleColor", controlType: .palette),
  ],
  "UILabel" : [
    Property(name: "text", controlType: .textField),
    Property(name: "textColor", controlType: .palette),
  ],
  "UIView" : [
    Property(name: "contentMode", controlType: .toggle),
    Property(name: "tintColor", controlType: .palette),
    Property(name: "backgroundColor", controlType: .palette),
  ],
  "UISwitch" : [
    Property(name: "isOn", controlType: .toggle),
    Property(name: "onImage", controlType: .toggle),
    Property(name: "offImage", controlType: .toggle),
  ],
  "UIStepper" : [
    Property(name: "wraps", controlType: .toggle),
    Property(name: "stepValue", controlType: .slider),
    Property(name: "autoRepeat", controlType: .toggle),
    Property(name: "isContinuous", controlType: .toggle),
  ],
  "UITextField" : [
    Property(name: "font", controlType: .slider),
    Property(name: "textColor", controlType: .palette),
    Property(name: "placeholder", controlType: .slider),
    Property(name: "borderStyle", controlType: .slider),
    Property(name: "textAlignment", controlType: .toggle),
  ],
  "UITableView" : [
    Property(name: "style", controlType: .slider),
    Property(name: "rowHeight", controlType: .slider),
    Property(name: "numberOfRows", controlType: .slider),
    Property(name: "numberOfSections", controlType: .slider),
    Property(name: "dequeueReusableCell", controlType: .slider),
  ],
  "UICollectionView" : [
    Property(name: "numberOfItems", controlType: .slider),
    Property(name: "numberOfSections", controlType: .slider),
    Property(name: "collectionViewLayout", controlType: .slider),
    Property(name: "layoutAttributesForSupplementaryElemnet", controlType: .slider),
  ],
  "UIImageView" : [
    Property(name: "isHighlighted", controlType: .slider),
    Property(name: "highlightImage", controlType: .slider),
    Property(name: "isUserInteractionEnabled", controlType: .slider),
  ],
  "UIPageControl" : [
    Property(name: "currentPage", controlType: .slider),
    Property(name: "numberOfPages", controlType: .slider),
  ],
  "UISegmentedControl" : [
    Property(name: "ismomentary", controlType: .slider),
    Property(name: "numberOfSegment", controlType: .slider),
  ]
]
