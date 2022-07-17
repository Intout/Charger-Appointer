//
//  AppointmentDetailsVew.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import UIKit

class AppointmentDetailsVew: UIView {

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 18)
        label.text = "Title"
        label.textColor = .lightGrey
        label.text = NSLocalizedString("appointmentDetails", comment: "")
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
    
    fileprivate lazy var dateStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("date", comment: "")
        return stackView
    }()
    
    fileprivate lazy var hourStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.titleLabel.text = NSLocalizedString("hour", comment: "")
        return stackView
    }()
    
    fileprivate lazy var appointmentLengthStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("appointmentLength", comment: "")
        return stackView
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(containerView)
        self.backgroundColor = .clear
        
        containerView.addSubview(vStackView)
        
        vStackView.addArrangedSubview(dateStack)
        vStackView.addArrangedSubview(hourStack)
        vStackView.addArrangedSubview(appointmentLengthStack)
        
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

extension AppointmentDetailsVew{
    func setDate(_ text: String){
        dateStack.descriptionLabel.text = text
    }
    func setHour(_ text: String){
        hourStack.descriptionLabel.text = text
    }
    func setAppointmentLength(_ text: String){
        appointmentLengthStack.descriptionLabel.text = text
    }
}
