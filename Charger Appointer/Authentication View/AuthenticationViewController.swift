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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    fileprivate let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: NSLocalizedString("welcomeTitle", comment: "Title of Welcome Message."))
        attributedText.highlight(color: .white, forText: "Charger", in: 24)
        
        label.translatesAutoresizingMaskIntoConstraints = false
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
        let attributedPlaceHolderText = NSMutableAttributedString(string: NSLocalizedString("eMailTextfieldTitle", comment: "Place holder title for button").uppercased())
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.lightGrey, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
        attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.font, value: UIFont.init(name: ApplicationFonts.light.rawValue, size: 12)!, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
        
        textField.font = UIFont.init(name: ApplicationFonts.light.rawValue, size: 16)
        textField.textColor = .white
        textField.attributedPlaceholder = attributedPlaceHolderText
        textField.addBottomBorder(with: UIColor.lightGrey, andWidth: 1, offset: 10)
        textField.keyboardType = .emailAddress
        textField.keyboardAppearance = .default
        textField.autocapitalizationType = .none
        
        
        return textField
    }()
    
    fileprivate let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.state
        label.font = UIFont.init(name: ApplicationFonts.light.rawValue, size: 12)
        return label
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
    
    var viewModel: AuthenticationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(containerView)
        containerView.addSubview(welcomeTitleLabel)
        containerView.addSubview(welcomeDialogLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(loginButton)
        containerView.addSubview(warningLabel)
        
        setupConstraints()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        view.backgroundColor = .charcoalGrey
        loginButton.layer.cornerRadius = 45/2
        
        
        self.navigationItem.title =  NSLocalizedString("login", comment: "Title of the View.")
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.titleView?.tintColor = .white
        
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
            
            warningLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            warningLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -75),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
    

}


// MARK: - UI Events
private extension AuthenticationViewController{
    @objc func buttonPressed(){
            self.viewModel?.loginButtonEvent(with: self.emailTextField.text){ message in
                self.toggleWarningLabel(with: message)
            }
    }
    func toggleWarningLabel(with message: String?){
        if message == nil {
            warningLabel.isHidden = true
            warningLabel.text = ""
        } else {
            warningLabel.isHidden = false
            warningLabel.text = message
        }
    }
}
