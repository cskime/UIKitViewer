//
//  HomeThumbnailGenerator.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import UIKit

class HomeThumbnailGenerator: NSObject {
    
    func generate(for name: String, inBounds bounds: CGRect) -> UIImage? {
        guard let view = makeViewInstance(with: name) else {
            return nil
        }
        
        view.sizeToFit()
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
    }
}


// MARK: - Making instance

private extension HomeThumbnailGenerator {
    
    func makeViewInstance(with name: String) -> UIView? {
        switch name {
        case "UIView":
            return makeInstance(of: UIView.self) {
                $0.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 80))
                $0.backgroundColor = .white
            }
            
        case "UILabel":
            return makeInstance(of: UILabel.self) {
                $0.text = "Label"
                $0.textAlignment = .center
            }
            
        case "UISwitch":
            return makeInstance(of: UISwitch.self) {
                $0.isOn = true
            }
            
        case "UISlider":
            return makeInstance(of: UISlider.self) {
                $0.value = 0.4
            }
            
        case "UIStepper":
            return makeInstance(of: UIStepper.self)
            
        case "UITextField":
            return makeInstance(of: UITextField.self) {
                $0.placeholder = "placeholder"
                $0.returnKeyType = .done
                $0.becomeFirstResponder()
                $0.borderStyle = .roundedRect
            }
            
        case "UIButton",
            "UITableView",
            "UICollectionView",
            "UISegmentedControl":
            return makeInstance(of: name)
            
        case "UIImageView":
            return makeInstance(of: UIImageView.self) {
                $0.image = ImageReference.dummy
            }
            
        case "UIPageControl":
            return makeInstance(of: UIPageControl.self) {
                $0.numberOfPages = 3
                $0.currentPage = 0
            }
            
        case "UIActivityIndicatorView":
            return makeInstance(of: UIActivityIndicatorView.self) {
                $0.hidesWhenStopped = false
                $0.style = .large
            }
            
        case "UIDatePicker":
            return makeInstance(of: UIDatePicker.self)
            
        default:
            return nil
        }
    }
    
    func makeInstance<T: UIView>(
        of type: T.Type,
        initialize: ((T) -> Void)? = nil
    ) -> T? {
        let instance = type.init()
        initialize?(instance)
        return instance
    }
    
    func makeInstance(of name: String) -> UIView? {
        let classType: AnyClass? = NSClassFromString(name)
        
        switch name {
        case "UIButton":
            guard let buttonType = classType as? UIButton.Type else {
                return nil
            }
            let button = buttonType.init(type: .system)
            button.setTitle("Button", for: .normal)
            return button
            
        case "UITableView":
            guard let tableViewType = classType as? UITableView.Type else {
                return nil
            }
            let tableView = tableViewType.init(
                frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
            )
            tableView.register(UITableViewCell.self)
            tableView.reloadData()
            return tableView
            
        case "UICollectionView":
            guard let collectionViewType = classType as? UICollectionView.Type else {
                return nil
            }
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 40, height: 40)
            layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            return collectionViewType.init(frame: .zero, collectionViewLayout: layout)
            
        case "UISegmentedControl":
            guard let segmentedControlType = classType as? UISegmentedControl.Type else {
                return nil
            }
            let segmentedControl = segmentedControlType.init(items: ["First", "Second"])
            segmentedControl.selectedSegmentIndex = 0
            return segmentedControl
            
        default:
            return nil
        }
    }
}

extension HomeThumbnailGenerator: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(UITableViewCell.self)
        cell?.textLabel?.text = "Item \(indexPath.row + 1)"
        return cell ?? UITableViewCell()
    }
}
