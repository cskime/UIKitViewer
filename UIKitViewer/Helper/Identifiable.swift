//
//  Identifiable.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

protocol Identifiable {
  static var identifier: String { get }
}
extension Identifiable {
  static var identifier: String { String(describing: self) }
}
