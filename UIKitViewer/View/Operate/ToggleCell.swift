//
//  ToggleCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class ToggleCell: UITableViewCell {
    
    static let identifier = String(describing: ToggleCell.self)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let onOffSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.setupConstraints()
    }
    
    struct UI {
        static let paddingY: CGFloat = 8
        static let paddingX: CGFloat = 16
        static let spacing: CGFloat = 8
    }
    
    private func setupConstraints() {
        let subviews = [self.nameLabel, self.onOffSwitch]
        subviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),

            self.onOffSwitch.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
            self.onOffSwitch.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -UI.paddingX),
            self.onOffSwitch.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UI.paddingY),
        ])
    }
    func configureContents(title: String) {
        self.nameLabel.text = title
    }
}
