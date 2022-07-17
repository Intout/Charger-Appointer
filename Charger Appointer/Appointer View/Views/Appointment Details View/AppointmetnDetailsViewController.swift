//
//  AppointmetnDetailsViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import UIKit

class AppointmetnDetailsViewController: UIViewController {

    fileprivate lazy var containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    fileprivate lazy var containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0)
        return scrollView
    }()
    
    fileprivate lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
      //  stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    fileprivate lazy var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark
        return view
    }()
    
    fileprivate lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("continue", comment: "Title of the Button.").uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    fileprivate lazy var stationInfoStack: AppointmentDetailsStationInfoView = {
        let stack = AppointmentDetailsStationInfoView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate lazy var socketInfoStack: AppointmentDetailsSocketInfoView = {
        let stack = AppointmentDetailsSocketInfoView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate lazy var appointmentInfoStack: AppointmentDetailsVew = {
        let stack = AppointmentDetailsVew()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    var viewModel: AppointmentDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        print("Veiw Loaded")
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containterView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
        
    }
    
    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("appointmentDetailsViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        
        view.addSubview(containterView)
        containterView.addSubview(containerScrollView)
        containterView.addSubview(buttonView)
        
        containerScrollView.addSubview(vStackView)
    
        buttonView.addSubview(confirmButton)
        
        vStackView.addArrangedSubview(stationInfoStack)
        vStackView.addArrangedSubview(socketInfoStack)
        vStackView.addArrangedSubview(appointmentInfoStack)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            containterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            containerScrollView.topAnchor.constraint(equalTo: containterView.topAnchor),
            containerScrollView.leadingAnchor.constraint(equalTo: containterView.leadingAnchor),
            containerScrollView.trailingAnchor.constraint(equalTo: containterView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
            vStackView.centerXAnchor.constraint(equalTo: containerScrollView.centerXAnchor),
            vStackView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor),
            vStackView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: containerScrollView.bottomAnchor, constant: 0),
            buttonView.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 0),
            buttonView.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: 0),
            buttonView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor),
            buttonView.widthAnchor.constraint(equalTo: containterView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 10),
            confirmButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 70),
            confirmButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -70),
            confirmButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -40),
            confirmButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
    
}

extension AppointmetnDetailsViewController: AppointmentDetailsViewModelDelegate{
    func didStationDataFetched(address: String, serviceHours: String, distance: String, stationCode: String, services: String) {
        DispatchQueue.main.async { [unowned self] in

            self.stationInfoStack.setAddress(address)
            self.stationInfoStack.setServiceHours(serviceHours)
            self.stationInfoStack.setDistance(distance)
            self.stationInfoStack.setStationCode(stationCode)
            self.stationInfoStack.setServices(services)
        }
    }
    func didSocketDataFetched(socketNo: String, chargerType: String, socketType: String, outputPower: String) {
        DispatchQueue.main.async { [unowned self] in
            self.socketInfoStack.setSocketNumber(socketNo)
            self.socketInfoStack.setChargerType(chargerType)
            self.socketInfoStack.setSocketType(socketType)
            self.socketInfoStack.setOutputPower(outputPower)
        }
    }
    func didAppointmentDataFetched(date: String, hour: String, appointmentLength: String) {
        DispatchQueue.main.async { [unowned self] in
            self.appointmentInfoStack.setDate(date)
            self.appointmentInfoStack.setHour(hour)
            self.appointmentInfoStack.setAppointmentLength(appointmentLength)
        }
    }
}

private extension AppointmetnDetailsViewController{
    @objc func buttonPressed(){
        viewModel.didConfirmButtonPressed()
    }
}
