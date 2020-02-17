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
      fatalError("UIView.ContentMode: Unknown Case")
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
      fatalError("UIView.ContentMode: Unknown Case")
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
      fatalError("UIView.ContentMode: Unknown Case")
    }
  }
}
