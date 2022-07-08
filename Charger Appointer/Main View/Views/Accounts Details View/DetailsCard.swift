//
//  DetailsCard.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 8.07.2022.
//

import UIKit

class DetailsCard: UIView {

    fileprivate lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.light.rawValue, size: 16)
        label.text = NSLocalizedString("emailTitle", comment: "Title.")
        label.textColor = .lightGrey
        return label
    }()

    private(set) lazy var emailTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 16)
        label.text = "email"
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var deviceIDTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.light.rawValue, size: 16)
        label.text = NSLocalizedString("idTitle", comment: "Title.")
        label.textColor = .lightGrey
        return label
    }()
    
    private(set) lazy var deviceIDTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 16)
        label.textColor = .white
        label.text = "DeviceID"
        return label
    }()
    
    fileprivate lazy var emailHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16.0
        return stackView
    }()
    
    fileprivate lazy var deviceIDlHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16.0
        return stackView
    }()
    
    fileprivate lazy var verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        emailHorizontalStack.addArrangedSubview(emailTitleLabel)
        emailHorizontalStack.addArrangedSubview(emailTextLabel)
        deviceIDlHorizontalStack.addArrangedSubview(deviceIDTitleLabel)
        deviceIDlHorizontalStack.addArrangedSubview(deviceIDTextLabel)
        self.layer.cornerRadius = 5
        verticalStack.addArrangedSubview(emailHorizontalStack)
        verticalStack.addArrangedSubview(deviceIDlHorizontalStack)
        
        self.addSubview(verticalStack)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .charcoalGrey
        self.dropShadow(radius: 2, opacity: 0.5, offset: CGSize(width: 0, height: 5))
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
}
