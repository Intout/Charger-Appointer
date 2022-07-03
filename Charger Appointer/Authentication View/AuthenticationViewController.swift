//
//  AuthenticationViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import UIKit

class AuthenticationViewController: UIViewController {
    fileprivate let containerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        let gradient = CAGradientLayer()
        
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        gradient.frame = view.bounds
        gradient.colors = [UIColor.dark, UIColor.charcoalGrey]
        view.layer.addSublayer(gradient)
                
        return view
    }()
    fileprivate let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: NSLocalizedString("welcomeTitle", comment: "Title of Welcome Message."))
        attributedText.highlight(color: .white, forText: "Charger", in: 24)
        label.font = UIFont.init(name: ApplicationFonts.regular.rawValue, size: 24)
        label.textColor = .white
        label.attributedText = attributedText
        
        return label
    }()
    fileprivate let welcomeDialogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = NSLocalizedString("welcomeDialog", comment: "Description of Welcome Message.")
        label.textColor = .lightGrey
        label.font = UIFont.init(name: ApplicationFonts.light.rawValue, size: 17)
        label.textAlignment = .center
        return label
    }()
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributedPlaceHolderText = NSMutableAttributedString(string: NSLocalizedString("eMailTextfieldTitle", comment: "Place holder title for button").uppercased())
        attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.lightGrey, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
        attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.font, value: UIFont.init(name: ApplicationFonts.light.rawValue, size: 12)!, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
        
        textField.font = UIFont.init(name: ApplicationFonts.light.rawValue, size: 16)
        textField.textColor = .white
        textField.attributedPlaceholder = attributedPlaceHolderText
        textField.addBottomBorder(with: UIColor.lightGrey, andWidth: 1, offset: 10)
        textField.keyboardType = .emailAddress
        textField.keyboardAppearance = .default
        
        
        return textField
    }()
    fileprivate let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("login", comment: "Title of the View.").uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(containerView)
        containerView.addSubview(welcomeTitleLabel)
        containerView.addSubview(welcomeDialogLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(loginButton)
        
        setupConstraints()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.backgroundColor = .charcoalGrey
        loginButton.layer.cornerRadius = 45/2
        
        
        self.navigationItem.title =  NSLocalizedString("login", comment: "Title of the View.")
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.titleView?.tintColor = .white
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }
    
    private func setupConstraints(){
                
        
        //Container View.
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Lables, TextField, Button
        NSLayoutConstraint.activate([
            welcomeTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            welcomeTitleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            welcomeDialogLabel.topAnchor.constraint(equalTo: welcomeTitleLabel.bottomAnchor, constant: 20),
            welcomeDialogLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            welcomeDialogLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            welcomeDialogLabel.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: welcomeDialogLabel.bottomAnchor, constant: 75),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -75),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        
        
        
    }
}

