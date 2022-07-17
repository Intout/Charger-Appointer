//
//  AppointmentDetailsSocketInfoView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import UIKit

class AppointmentDetailsSocketInfoView: UIView {

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 18)
        label.text = "Title"
        label.textColor = .lightGrey
        label.text = NSLocalizedString("socketInfo", comment: "")
        return label
    }()
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .charcoalGrey.withAlphaComponent(0.5)
        return view
    }()
    
    fileprivate lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        //stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    fileprivate lazy var socketNumberStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("socketNumber", comment: "")
        return stackView
    }()
    
    fileprivate lazy var chargerTypeStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.titleLabel.text = NSLocalizedString("chargerType", comment: "")
        return stackView
    }()
    
    fileprivate lazy var socketTypeStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("socketType", comment: "")
        return stackView
    }()
    
    fileprivate lazy var outputPowerStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("outputPower", comment: "")
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(containerView)
        self.backgroundColor = .clear
        
        containerView.addSubview(vStackView)
        
        vStackView.addArrangedSubview(socketNumberStack)
        vStackView.addArrangedSubview(chargerTypeStack)
        vStackView.addArrangedSubview(socketTypeStack)
        vStackView.addArrangedSubview(outputPowerStack)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),
        ])
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            vStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            vStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            vStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
        ])
        
    }
}

extension AppointmentDetailsSocketInfoView{
    func setSocketNumber(_ text: String){
        socketNumberStack.descriptionLabel.text = text
    }
    func setChargerType(_ text: String){
        chargerTypeStack.descriptionLabel.text = text
    }
    func setSocketType(_ text: String){
        socketTypeStack.descriptionLabel.text = text
    }
    func setOutputPower(_ text: String){
        outputPowerStack.descriptionLabel.text = text
    }
}
