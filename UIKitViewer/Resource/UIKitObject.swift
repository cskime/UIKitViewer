//
//  UIKitObjects.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

// MARK:- Target Objects

struct ObjectInfo {
  var object: UIKitObject
  var properties: [Property]
}

struct Property {
  var name: String
  var controlType: CellControlType
}

enum UIKitObject: String, CaseIterable, Hashable {
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
  
  var properties: [Property] {
    switch self {
    case .UIView:
      return [
        Property(name: "contentMode", controlType: .select),
        Property(name: "tintColor", controlType: .palette),
        Property(name: "backgroundColor", controlType: .palette),
        Property(name: "clipsToBounds", controlType: .toggle),
        Property(name: "alpha", controlType: .slider),
        Property(name: "isHidden", controlType: .toggle),
        Property(name: "layer.borderWidth", controlType: .slider),
        Property(name: "layer.borderColor", controlType: .palette),
        Property(name: "layer.cornerRadius", controlType: .slider)
      ]
    case .UIButton:
      return [
        Property(name: "setTitle", controlType: .textField),
        Property(name: "setTitleColor", controlType: .palette),
        Property(name: "setImage", controlType: .toggle),
        Property(name: "setBackgroundImage", controlType: .toggle)
      ]
    case .UILabel:
      return [
        Property(name: "text", controlType: .textField),
        Property(name: "textColor", controlType: .palette),
        Property(name: "numberOfLines", controlType: .slider)
      ]
    case.UISwitch:
      return [
        Property(name: "isOn", controlType: .toggle),
        Property(name: "setOn", controlType: .toggle),
        Property(name: "onTintColor", controlType: .palette),
        Property(name: "thumbTintColor", controlType: .palette)
      ]
    case .UIStepper:
      return [
        Property(name: "setIncrementImage", controlType: .toggle),
        Property(name: "setDecrementImage", controlType: .toggle),
        Property(name: "setDividerImage", controlType: .toggle)
      ]
    case .UITextField:
      return [
        Property(name: "textColor", controlType: .palette),
        Property(name: "placeholder", controlType: .toggle),
        Property(name: "borderStyle", controlType: .select),
        Property(name: "clearButtonMode", controlType: .select),
      ]
    case .UITableView:
      return [
        Property(name: "style", controlType: .select),
        Property(name: "separatorColor", controlType: .palette),
      ]
    case .UICollectionView:
      return [
        Property(name: "collectionViewLayout.itemSize", controlType: .slider),
        Property(name: "collectionViewLayout.minimumLineSpacing", controlType: .slider),
        Property(name: "collectionViewLayout.minimumInteritemSpacing",controlType: .slider),
        Property(name: "collectionViewLayout.sectionInset", controlType: .slider),
        Property(name: "collectionViewLayout.headerReferenceSize", controlType: .slider),
        Property(name: "collectionViewLayout.footerReferenceSize", controlType: .slider),
      ]
    case .UIImageView:
      return [
      ]
    case .UIPageControl:
      return [
        Property(name: "currentPage", controlType: .slider),
        Property(name: "numberOfPages", controlType: .slider),
      ]
    case .UISegmentedControl:
      return [
      ]
    }
  }
  
  var objectsWithinInheritance: [Self] {
    guard var currentType = NSClassFromString(self.rawValue) as? UIView.Type else { return [] }

    var objects = [self]
    guard self != .UIView else { return objects }
    
    
    while let superType = currentType.superclass() as? UIView.Type {
      let stringObject = String(describing: type(of: superType.init()))
      guard let object = UIKitObject(rawValue: stringObject) else {
        currentType = superType
        continue
      }
      objects.append(object)
      if object == .UIView { break }
      else { currentType = superType }
    }
    
    return objects
  }
  
  func makeInstance() -> UIView? {
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
    default:
      return nil
    }
  }

}
