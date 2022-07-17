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
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    fileprivate lazy var stationInfoStack: AppointmentDetailsStationInfoView = {
        let stack = AppointmentDetailsStationInfoView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    var viewModel: AppointmentDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containterView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
        
    }
    
    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("appointmentDetailsViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        
        view.addSubview(containterView)
        containterView.addSubview(containerScrollView)
        containerScrollView.addSubview(vStackView)
        vStackView.addArrangedSubview(stationInfoStack)
        
        
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
            containerScrollView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
            vStackView.centerXAnchor.constraint(equalTo: containerScrollView.centerXAnchor),
            vStackView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor),
            vStackView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
        ])
        
    }
    
}
