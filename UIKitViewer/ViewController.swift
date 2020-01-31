//
//  ViewController.swift
//  UIKitViewer
//
//  Created by cskim on 2020/01/31.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    label.center = self.view.center
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 24)
    label.text = "Label"
    self.view.addSubview(label)
  }


}

