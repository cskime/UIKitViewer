//
//  OperationViewController.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/03.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController {
    
    private let cellProvider = CellProvider()
    private let objectManager = ObjectManager.shared
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var displayView = DisplayView(objectType: self.objectManager.object)
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    deinit {
        self.objectManager.dataSource.removeAll()
    }
    
    // MARK: Initialize
    
    private func setupUI() {
        self.setupAttributes()
        self.setupTableView()
        self.setupConstraints()
        self.cellProvider.delegate = self
        self.cellProvider.register(to: self.tableView)
    }
    
    private func setupAttributes() {
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        navigationItem.title = objectManager.dataSource.first?.name
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    struct UI {
        static let paddingY: CGFloat = 24
        static let paddingX: CGFloat = 24
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
            self.displayView.topAnchor.constraint(equalTo: guide.topAnchor, constant: UI.paddingY),
            self.displayView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: UI.paddingX),
            self.displayView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -UI.paddingX),
            self.displayView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3),
            
            self.tableView.topAnchor.constraint(equalTo: self.displayView.bottomAnchor, constant: UI.paddingY),
            self.tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
}

// MARK:- UITableViewDataSource

extension OperationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectManager.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectManager.dataSource[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectManager.dataSource[section].properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let property = objectManager.dataSource[indexPath.section].properties[indexPath.row]
        let cell = self.cellProvider.create(to: tableView, with: property.name, for: property.controlType)
        return cell
    }
    
}

// MARK:- ControlCellDelegate

extension OperationViewController: ControlCellDelegate {
    
    func cell(_ tableViewCell: UITableViewCell, valueForColor color: UIColor?) {
        guard let cell = tableViewCell as? PaletteCell else { return }
        if cell.nameLabel.text!.contains("backgroundColor") {
            self.displayView.configure(backgroundColor: color)
        } else if cell.nameLabel.text!.contains("tint") {
            self.displayView.configure(tintColor: color)
        } else if cell.nameLabel.text!.contains("Title") || cell.nameLabel.text!.contains("text") {
            self.displayView.configure(textColor: color)
        } else {
            return
        }
    }
    
    func cell(_ tableViewCell: UITableViewCell, valueForSelect value: Bool) {
        
        let titles = ["Top", "Left", "Right", "Bottom", "Cancel"]
        guard let cell = tableViewCell as? SelectCell else { return }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        titles.forEach { title in
            let style: UIAlertAction.Style = (title == "Cancel") ? .cancel : .default
            let action = UIAlertAction(title: title, style: style) { _ in
                cell.selectButton.setTitle(title, for: .normal)
            }
            alertController.addAction(action)
        }
        
//        let topAction = UIAlertAction(title: "Top", style: .default) { ( action) in }
//        alertController.addAction(topAction)
//
//        let leftAction = UIAlertAction(title: "Left", style: .default) { _ in }
//        alertController.addAction(leftAction)
//
//        let rightAction = UIAlertAction(title: "Right", style: .default) { _ in }
//        alertController.addAction(rightAction)
//
//        let bottomAction = UIAlertAction(title: "Bottom", style: .default) { _ in }
//        alertController.addAction(bottomAction)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
//        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}

