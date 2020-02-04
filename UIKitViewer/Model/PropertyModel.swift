//
//  Properties.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

enum ControlType {
  case slider
  case palette
  case toggle
}

struct Property {
  var name: String
  var controlType: ControlType
}

var properties: [String: [Property]] = [
  "UIButton" : [
    Property(name: "setTitle", controlType: .slider),
    Property(name: "setImage", controlType: .toggle),
    Property(name: "setTitleColor", controlType: .palette),
  ],
  "UILabel" : [
    Property(name: "text", controlType: .slider),
    Property(name: "textColor", controlType: .slider),
  ],
  "UIView" : [
    Property(name: "tintColor", controlType: .slider),
    Property(name: "backgroundColor", controlType: .slider),
  ],
  "UISwitch" : [
    Property(name: "isOn", controlType: .slider),
    Property(name: "onImage", controlType: .slider),
    Property(name: "offImage", controlType: .slider),
  ],
  "UIStepper" : [
    Property(name: "wraps", controlType: .slider),
    Property(name: "stepValue", controlType: .slider),
    Property(name: "autoRepeat", controlType: .slider),
    Property(name: "isContinuous", controlType: .slider),
  ],
  "UITextField" : [
    Property(name: "font", controlType: .slider),
    Property(name: "textColor", controlType: .slider),
    Property(name: "placeholder", controlType: .slider),
    Property(name: "borderStyle", controlType: .slider),
    Property(name: "textAlignment", controlType: .slider),
  ],
  "UITableView" : [
    Property(name: "style", controlType: .slider),
    Property(name: "rowHeight", controlType: .slider),
    Property(name: "cellForRow", controlType: .slider),
    Property(name: "numberOfRows", controlType: .slider),
    Property(name: "dequeueReusableCell", controlType: .slider),
  ],
  "UICollectionView" : [
    Property(name: "register", controlType: .slider),
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
