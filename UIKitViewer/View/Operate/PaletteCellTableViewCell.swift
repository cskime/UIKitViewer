//
//  PaletteCellTableViewCell.swift
//  UIKitViewer
//
//  Created by mac on 2020/02/04.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit

class PaletteCellTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: PaletteCellTableViewCell.self)
    
    private let view: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let clearButton: UIButton = {
        let clearButton = UIButton()
        clearButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        clearButton.frame.size = CGSize(width: 10, height: 10)
        clearButton.alpha = 0.1
        return clearButton
    }()
    private let redButton: UIButton = {
        let redButton = UIButton()
        redButton.frame.size = CGSize(width: 10, height: 10)
        redButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return redButton
    }()
    private let blueButton: UIButton = {
        let blueButton = UIButton()
        blueButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        blueButton.frame.size = CGSize(width: 10, height: 10)
        return blueButton
    }()
    private let greenButton: UIButton = {
        let greenButton = UIButton()
        greenButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        greenButton.frame.size = CGSize(width: 10, height: 10)
        return greenButton
    }()
    private let orangeButton: UIButton = {
        let orangeButton = UIButton()
        orangeButton.backgroundColor = #colorLiteral(red: 1, green: 0.3927565978, blue: 0, alpha: 1)
        orangeButton.frame.size = CGSize(width: 10, height: 10)
        return orangeButton
    }()
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
        let subviews = [self.nameLabel, self.clearButton, self.redButton, self.blueButton, self.greenButton, self.orangeButton]
        subviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UI.paddingY),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
            
            self.clearButton.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.paddingY),
            self.clearButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: UI.paddingX),
            self.clearButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: UI.paddingX),
            
            self.redButton.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.paddingY),
            self.redButton.leadingAnchor.constraint(equalTo: self.clearButton.leadingAnchor, constant: UI.paddingX),
            self.redButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: UI.paddingX),
            
            self.blueButton.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.paddingY),
            self.blueButton.leadingAnchor.constraint(equalTo: self.redButton.leadingAnchor, constant: UI.paddingX),
            self.blueButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: UI.paddingX),
            
            self.greenButton.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.paddingY),
            self.greenButton.leadingAnchor.constraint(equalTo: self.blueButton.leadingAnchor, constant: UI.paddingX),
            self.greenButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: UI.paddingX),
            
            self.orangeButton.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: UI.paddingY),
            self.orangeButton.leadingAnchor.constraint(equalTo: self.greenButton.leadingAnchor, constant: UI.paddingX),
            self.orangeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: UI.paddingX),
        ])
    }
    func configureContents(title: String) {
        self.nameLabel.text = title
    }
}
