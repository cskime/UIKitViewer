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
      .top, .topLeft, .topRight,
      .bottom, .bottomLeft, .bottomRight,
      .left, .right, .center,
      .scaleToFill, .scaleAspectFill, .scaleAspectFit,
      .redraw
    ]
  }
  var stringRepresentation: String {
    get {
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
}
