//
//  Extensions.swift
//  UIKitViewer
//
//  Created by cskim on 2020/02/06.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

protocol EnumerationExtension: CaseIterable {
  var stringRepresentation: String { get }
}

extension UIView.ContentMode: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .scaleToFill,
      .scaleAspectFit,
      .scaleAspectFill,
      .redraw,
      .center,
      .top,
      .bottom,
      .left,
      .right,
      .topLeft,
      .topRight,
      .bottomLeft,
      .bottomRight,
    ]
  }
  var stringRepresentation: String {
    switch self {
    case .top:              return "top"
    case .topLeft:          return "topLeft"
    case .topRight:         return "topRight"
    case .bottom:           return "bottom"
    case .bottomLeft:       return "bottomLeft"
    case .bottomRight:      return "bottomRight"
    case .left:             return "left"
    case .right:            return "right"
    case .center:           return "center"
    case .redraw:           return "redraw"
    case .scaleToFill:      return "scaleToFill"
    case .scaleAspectFill:  return "scaleAspectFill"
    case .scaleAspectFit:   return "scaleAspectFit"
    @unknown default:
      fatalError("UIView.ContentMode: Unknown Case")
    }
  }
}

extension UITableView.Style: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .plain,
      .grouped,
      .insetGrouped,
    ]
  }
  var stringRepresentation: String {
    switch self {
    case .grouped:        return "grouped"
    case .insetGrouped:   return "insetGrouped"
    case .plain:          return "plain"
    @unknown default:
      fatalError("UITableView.Style: Unknown Case")
    }
  }
}

extension UITableViewCell.SeparatorStyle {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .none,
      .singleLine
    ]
  }
  var stringRepresentation: String {
    switch self {
    case .none:        return "none"
    case .singleLine:   return "singleLine"
    default:
      fatalError("UITableView.SeparatorStyle: Unknown Case")
    }
  }
}

extension UITextField.BorderStyle: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .none,
      .line,
      .bezel,
      .roundedRect,
    ]
  }
  var stringRepresentation: String {
    switch self {
    case .none:         return "none"
    case .line:         return "line"
    case .bezel:        return "bezel"
    case .roundedRect:  return "roundedRect"
    @unknown default:
      fatalError("UITextField.BorderStyle: Unknown Case")
    }
  }
}

extension UITextField.ViewMode: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .never,
      .whileEditing,
      .unlessEditing,
      .always,
    ]
  }
  var stringRepresentation: String {
    switch self {
    case .never:         return "never"
    case .whileEditing:  return "whileEditing"
    case .unlessEditing: return "unlessEditing"
    case .always:        return "always"
    @unknown default:
      fatalError("UITextField.ViewMode: Unknown Case")
    }
  }
}

extension UIButton.ButtonType: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .custom,
      .system,
      .detailDisclosure,
      .infoLight,
      .infoDark,
      .contactAdd,
      .close,
    ]
  }
  
  var stringRepresentation: String {
    switch self {
    case .custom:             return "custom"
    case .system:             return "system"
    case .detailDisclosure:   return "detailDisclosure"
    case .infoLight:          return "infoLight"
    case .infoDark:           return "infoDark"
    case .contactAdd:         return "contactAdd"
    case .close:              return "close"
    @unknown default:
      fatalError("UIButton.ButtonType: Unknown Case")
    }
  }
}

extension NSLineBreakMode: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .byWordWrapping,
      .byCharWrapping,
      .byClipping,
      .byTruncatingHead,
      .byTruncatingTail,
      .byTruncatingMiddle,
    ]
  }
  
  var stringRepresentation: String {
    switch self {
    case .byWordWrapping:     return "byWordWrapping"
    case .byCharWrapping:     return "byCharWrapping"
    case .byClipping:         return "byClipping"
    case .byTruncatingHead:   return "byTruncatingHead"
    case .byTruncatingTail:   return "byTruncatingTail"
    case .byTruncatingMiddle: return "byTruncatingMiddle"
    @unknown default:
      fatalError("NSLineBreakMode: Unknown Case")
    }
  }
}

extension NSTextAlignment: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .left,
      .center,
      .right,
      .justified,
      .natural
    ]
  }
  var stringRepresentation: String {
    switch self {
    case .left:             return "left"
    case .right:            return "right"
    case .center:           return "center"
    case .justified:        return "justified"
    case .natural:          return "natural"
    @unknown default:
      fatalError("NSTextAlignment: Unknown Case")
    }
  }
}

extension UICollectionView.ScrollDirection: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .vertical,
      .horizontal
    ]
  }
  
  var stringRepresentation: String {
    switch self {
    case .vertical:             return "vertical"
    case .horizontal:           return "horizontal"
    @unknown default:
      fatalError("UICollectionView.ScrollDirection: Unknown Case")
    }
  }
}

extension UIActivityIndicatorView.Style: EnumerationExtension {
  public typealias AllCases = [Self]
  public static var allCases: [Self] {
    return [
      .medium,
      .large
    ]
  }
  
  var stringRepresentation: String {
    switch self {
    case .medium:   return "medium"
    case .large:    return "large"
    default:
      fatalError("UIActivityIndicator: Unknown Case")
    }
  }
}
