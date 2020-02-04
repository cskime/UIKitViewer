//
//  OperationViewController.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController {
  
  private let manager = Manager.shared
  private let tableView = UITableView(frame: .zero, style: .grouped)
  private let displayView = UIView()
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  deinit {
    self.manager.dataSource.removeAll()
  }
  
  // MARK: Initialize
  
  private func setupUI() {
    self.setupAttributes()
    self.setupTableView()
    self.setupConstraints()
  }
  
  private func setupAttributes() {
    self.view.backgroundColor = .white
    navigationItem.title = manager.dataSource.first?.name
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.register(SliderCell.self, forCellReuseIdentifier: SliderCell.identifier)
    tableView.allowsSelection = false
  }
  
  struct UI {
    static let displayHeight: CGFloat = 240
  }
  private func setupConstraints() {
    let subviews = [self.displayView, self.tableView]
    subviews.forEach {
      self.view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let guide = self.view.safeAreaLayoutGuide
    self.displayView.backgroundColor = .lightText
    NSLayoutConstraint.activate([
      self.displayView.topAnchor.constraint(equalTo: guide.topAnchor),
      self.displayView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      self.displayView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      self.displayView.heightAnchor.constraint(equalToConstant: UI.displayHeight),
      
      self.tableView.topAnchor.constraint(equalTo: self.displayView.bottomAnchor),
      self.tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      self.tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
    ])
    
    self.setupTargetObject()
  }
  
  private func setupTargetObject() {
    
    var object: UIView
    var willLayoutSize = false
    switch manager.object {
    case .UIButton:
      guard let button = manager.object.getInstance() as? UIButton else { return }
      button.setTitle("Test Button", for: .normal)
      button.setTitleColor(.black, for: .normal)
      object = button
    case .UILabel:
      guard let label = manager.object.getInstance() as? UILabel else { return }
      label.text = "Test Label"
      object = label
    case .UIView:
      object = UIView()
      object.backgroundColor = .black
      willLayoutSize = true
    }
    
    self.displayView.addSubview(object)
    object.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      object.centerXAnchor.constraint(equalTo: self.displayView.centerXAnchor),
      object.centerYAnchor.constraint(equalTo: self.displayView.centerYAnchor),
    ])
    
    if willLayoutSize {
      NSLayoutConstraint.activate([
        object.widthAnchor.constraint(equalTo: self.displayView.widthAnchor, multiplier: 0.5),
        object.heightAnchor.constraint(equalTo: self.displayView.heightAnchor, multiplier: 0.5),
      ])
    }
    
  }
  
}

// MARK:- UITableViewDataSource

extension OperationViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return manager.dataSource.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return manager.dataSource[section].name
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return manager.dataSource[section].properties.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let title = manager.dataSource[indexPath.section].properties[indexPath.row]
    let cell = CellProvider.create(to: tableView, with: title, for: .slider)
    return cell
  }
  
}

