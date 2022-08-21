//
//  TypeCastable.swift
//  UIKitViewer
//
//  Created by Chamsol Kim on 2022/08/21.
//  Copyright © 2022 cskim. All rights reserved.
//

import Foundation

protocol TypeCastable {
    func cast<T>(to type: T.Type) -> T?
}

extension TypeCastable {
    func cast<T>(to type: T.Type) -> T? {
        self as? T
    }
}

extension NSObject: TypeCastable {}

