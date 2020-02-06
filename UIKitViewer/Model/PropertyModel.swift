//
//  Properties.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

struct Property {
  var name: String
  var controlType: ControlType
}
var properties: [String: [Property]] = [
  "CALayer" : [
    Property(name: "borderWidth", controlType: .slider),
    Property(name: "borderColor", controlType: .palette),
    Property(name: "cornerRadius", controlType: .slider)
  ],
  "UIButton" : [
    Property(name: "setTitle", controlType: .textField),
    Property(name: "setTitleColor", controlType: .palette),
    Property(name: "setImage", controlType: .toggle),
    Property(name: "setBackgroundImage", controlType: .toggle)
  ],
  "UILabel" : [
    Property(name: "text", controlType: .textField),
    Property(name: "textColor", controlType: .palette),
    Property(name: "numberOfLines", controlType: .slider)
  ],
  "UIView" : [
    Property(name: "contentMode", controlType: .select),
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
    Property(name: "setIncrementImage", controlType: .toggle),
    Property(name: "setDecrementImage", controlType: .toggle),
    Property(name: "setDividerImage", controlType: .toggle)
  ],
  "UITextField" : [
    Property(name: "textColor", controlType: .palette),
    Property(name: "placeholder", controlType: .toggle),
    Property(name: "borderStyle", controlType: .select),
    Property(name: "clearButtonMode", controlType: .select),
  ],
  "UITableView" : [
    Property(name: "style", controlType: .select),
    Property(name: "separatorColor", controlType: .palette),
  ],
  "UICollectionView" : [
    ],
  "UICollectionViewFlowLayout" : [
    Property(name: "itemSize", controlType: .slider),
    Property(name: "minimumLineSpacing", controlType: .slider),
    Property(name: "minimumInteritemSpacing",controlType: .slider),
    Property(name: "sectionInset", controlType: .slider),
    Property(name: "headerReferenceSize", controlType: .slider),
    Property(name: "footerReferenceSize", controlType: .slider),
    ],
  "UIImageView" : [
  ],
  "UIPageControl" : [
    Property(name: "currentPage", controlType: .slider),
    Property(name: "numberOfPages", controlType: .slider),
  ],
  "UISegmentedControl" : [
  ]
]
