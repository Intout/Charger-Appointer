//
//  AppointmentScreenMessageView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import UIKit

class AppointmentScreenMessageView: UIView {

    fileprivate lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20.0
        return stack
    }()
    
    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Badge1")
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = NSLocalizedString("noAppointmentTitle", comment: "Title message") + "."
        label.font = UIFont.init(name: ApplicationFonts.regular.rawValue, size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = NSLocalizedString("noAppointmentMessage", comment: "Welcome Message.") + "."
        label.textColor = .lightGrey
        label.font = UIFont.init(name: ApplicationFonts.light.rawValue, size: 17)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerStack)
        containerStack.addArrangedSubview(iconImageView)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: self.topAnchor),
            containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            containerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
