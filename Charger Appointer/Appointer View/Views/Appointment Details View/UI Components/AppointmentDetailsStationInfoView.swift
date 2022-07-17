//
//  AppointmentDetailsStationInfoStackVew.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import UIKit

class AppointmentDetailsStationInfoView: UIView {

    fileprivate lazy var titelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 18)
        label.text = "Title"
        label.textColor = .lightGrey
        label.text = NSLocalizedString("stationInfo", comment: "")
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
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    fileprivate lazy var addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    fileprivate lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("address", comment: "")
        return label
    }()
    
    private(set) lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        label.textColor = .lightGrey
        return label
    }()
    
    fileprivate lazy var serviceHoursStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("serviceHours", comment: "")
        return stackView
    }()
    
    fileprivate lazy var distanceStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.titleLabel.text = NSLocalizedString("distance", comment: "")
        return stackView
    }()
    
    fileprivate lazy var stationCodeStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("stationCode", comment: "")
        return stackView
    }()
    
    fileprivate lazy var servicesStack: AppointmentDetailsRowStackView = {
        let stackView = AppointmentDetailsRowStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.titleLabel.text = NSLocalizedString("services", comment: "")
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titelLabel)
        self.addSubview(containerView)
        self.backgroundColor = .clear
    
        containerView.addSubview(vStackView)
        
        addressStackView.addArrangedSubview(addressTitleLabel)
        addressStackView.addArrangedSubview(addressLabel)
        
        vStackView.addArrangedSubview(addressStackView)
        vStackView.addArrangedSubview(serviceHoursStack)
        vStackView.addArrangedSubview(distanceStack)
        vStackView.addArrangedSubview(stationCodeStack)
        vStackView.addArrangedSubview(servicesStack)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            titelLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titelLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titelLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: titelLabel.bottomAnchor, constant: 10),
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


extension AppointmentDetailsStationInfoView{
    func setServiceHours(_ text: String){
        serviceHoursStack.descriptionLabel.text = text
    }
    func setDistance(_ text: String){
        distanceStack.descriptionLabel.text = text
    }
    func setStationCode(_ text: String){
        stationCodeStack.descriptionLabel.text = text
    }
    func setServices(_ text: String){
        servicesStack.descriptionLabel.text = text
    }
}
