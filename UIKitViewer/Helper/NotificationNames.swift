//
//  CellNotification.swift
//  UIKitViewer
//
//  Created by cskim on 2020/03/10.
//  Copyright © 2020 cskim. All rights reserved.
//

import Foundation

extension UIKitObject {
  /// Display View에서 Control Cell로부터 Request 직후 Response를 전달할 object를 특정하기 위한 Notification
  var responseDisplayedObjectNotification: Notification.Name {
    return Notification.Name(rawValue: "\(self).responseDisplayedObjectNotification")
  }
}

extension ControlCell {
  /// Display View에서 Control Cell로부터 Notification을 받기 위한 Notification
  static var requestDisplayedObjectNotification = Notification.Name("requestDisplayedObjectNotification")
}

extension StepperCell {
  /// UIPageControl에서 currentPage와 numberOfPages 사이의 의존성 관계를 해결하기 위해
  /// StepperCell에서 pageControl을 위해 private하게 사용되는 Notification
  static var pageControlNumberOfPagesDidChangeNotification: Notification.Name {
    return Notification.Name(rawValue: "pageControlNumberOfPagesDidChange")
  }
}

extension ToggleCell {
  static var switchIsOnDidChangeNotification: Notification.Name {
    return Notification.Name(rawValue: "switchIsOnDidChangeNotification")
  }
}
