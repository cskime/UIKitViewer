//
//  SelectCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/06.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class SelectCell: UITableViewCell {
    
    static let identifier = String(describing: SelectCell.self)
    
    weak var delegate: ControlCellDelegate?
    
    static let contentModeData = ["Left","Right","Top","Bottom"]
 
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let selectButton: UIButton = {
        let selectButton = UIButton()
        return selectButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapButton(_ sender: UIButton) {
        self.delegate?.cell?(self, valueForSelect: sender.isSelected)
    }
    
    struct UI {
        static let paddingY: CGFloat = 8
        static let paddingX: CGFloat = 16
        static let spacing: CGFloat = 8
    }
    private func setupUI() {
        selectButtonUI()
        setupConstraints()
    }
     func selectButtonUI() {
        selectButton.setTitle("Button", for: .normal)
        selectButton.setTitleColor(.black, for: .normal)
        selectButton.backgroundColor = .white
        selectButton.layer.borderColor = UIColor.black.cgColor
        selectButton.layer.borderWidth = 0.5
        selectButton.layer.cornerRadius = 5
        selectButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
     func setupConstraints() {
        let subviews = [self.nameLabel, self.selectButton]
        subviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
            
            self.selectButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
            self.selectButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
            self.selectButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
        ])
    }

    func configure(title: String) {
        self.nameLabel.text = title
    }
}
