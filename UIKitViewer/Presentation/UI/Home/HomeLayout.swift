//
//  HomeLayout.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/28/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import UIKit

enum HomeLayout {
    static let itemSpacing: CGFloat = 10
    static let lineSpacing: CGFloat = 10
    static let sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    static var itemSize: CGSize {
        let inset: CGFloat = 16
        let width = (UIScreen.main.bounds.width - itemSpacing - inset * 2) / 2
        let height = width * 0.9
        return CGSize(width: width, height: height)
    }
    
    static let titleHeight: CGFloat = 40
}
