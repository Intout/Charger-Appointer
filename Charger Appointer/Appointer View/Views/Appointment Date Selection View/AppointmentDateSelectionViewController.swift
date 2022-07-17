//
//  AppointmentDataSelectionViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import UIKit

class AppointmentDataSelectionViewController: UIViewController {

    fileprivate let containterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    fileprivate let containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(white: 1, alpha: 0)
        return scrollView
    }()
    
    fileprivate lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
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
    
    fileprivate lazy var continueButton: UIButton = {
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
    
    fileprivate lazy var datePickerView: AppointmentDateSelectionDatePickerView = {
       let picker = AppointmentDateSelectionDatePickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.titleLabel.text = NSLocalizedString("appointmentDate", comment: "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        picker.textDatePicker.text = dateFormatter.string(from: Date.now)
        return picker
    }()
    
    fileprivate lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    var viewModel: AppointmentDateSelectionViewModel?
    var socketViews: [AppointerDateSelectionSocketHourStackView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touchedOnView))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        containerScrollView.addGestureRecognizer(recognizer)
        viewModel?.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containterView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
        
    }
    
    @objc private func touchedOnView(){
        if self.datePickerView.textDatePicker.firstResponder != nil{
            print("First Responder exists")
            self.datePickerView.endEditing(true)
            viewModel?.updateDate(with: self.datePickerView.textDatePicker.text!)
        }
    }
    
    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("appointmentDateSelectionViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        view.addSubview(containterView)
        containterView.addSubview(containerScrollView)
        containterView.addSubview(buttonView)
        buttonView.addSubview(continueButton)
        containerScrollView.addSubview(datePickerView)
        containerScrollView.addSubview(hStack)
        
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
            //containerScrollView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: containerScrollView.bottomAnchor, constant: 0),
            buttonView.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 0),
            buttonView.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: 0),
            buttonView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor),
            buttonView.widthAnchor.constraint(equalTo: containterView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 10),
            continueButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 70),
            continueButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -70),
            continueButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -40),
            continueButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
        
            datePickerView.topAnchor.constraint(equalTo: containerScrollView.topAnchor, constant: 20),
            datePickerView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 10),
            datePickerView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: datePickerView.bottomAnchor, constant: 40),
            hStack.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 0),
            hStack.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: 0),
            hStack.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
            hStack.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor)
        ])
        
        
    
    }
    
    private func generateSocketData(_ data: [AppointmentSocket]){
        
        DispatchQueue.main.async { [unowned self] in
            
            if !self.socketViews.isEmpty{
                for view in self.socketViews{
                    print("Updated")
                    view.removeFromSuperview()
                    
                }
                self.socketViews = []
                
            }
            for datum in data {
                let socketHourStackView = AppointerDateSelectionSocketHourStackView()
                socketHourStackView.setID(id: String(datum.socketID))
                socketHourStackView.setSelectedCellData(viewModel?.getSelectedSocket())
                socketHourStackView.setData(datum.day.timeSlots)
                socketHourStackView.titleLabel.text = NSLocalizedString("socket", comment: "") + " " + String(datum.socketNumber)
                socketHourStackView.chargerInfoLabel.text = "\(datum.chargeType) · \(datum.socketType)"
                socketHourStackView.delegate = self
                self.socketViews.append(socketHourStackView)
                self.hStack.addArrangedSubview(socketHourStackView)
            }
        }
    }
    
    private func updateSocketViewsSelectedCell(){
        for view in socketViews{
            view.setSelectedCellData(viewModel?.getSelectedSocket())
        }
    }
}

extension AppointmentDataSelectionViewController: AppointmentDateSelectionViewModelDelegate{
    func didDataFetch(_ data: [AppointmentSocket]) {
        print(data)
        viewModel?.setSelectedSocket(nil)
        generateSocketData(data)
    }
    func didDataFetchFailed(_ error: Error?) {
        print("Data fetch failed with: \(error)")
    }
    
    func didDateEditSelected() {
        self.datePickerView.textDatePicker.becomeFirstResponder()
    }
    func didTodayDateSelected() {
        self.datePickerView.updateDateToToday()
    }
}

extension AppointmentDataSelectionViewController: AppointerDateSelectionSocketHourStackViewDelegate{
    func didCellSelected(id: String, slot: String) {
        viewModel?.setSelectedSocket(SelectedSocket(id: id, slot: slot))
        updateSocketViewsSelectedCell()
    }
}

private extension AppointmentDataSelectionViewController{
    @objc func buttonPressed(){
        viewModel?.continueButtonEvent()
    }
}
