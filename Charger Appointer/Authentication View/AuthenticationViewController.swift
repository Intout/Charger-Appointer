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
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: NSLocalizedString("welcomeTitle", comment: "Title of Welcome Message."))
        attributedText.highlight(color: .white, forText: "Charger", in: 24)
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.attributedText = attributedText
        
        return label
    }()
    fileprivate let welcomeDialogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = NSLocalizedString("welcomeDialog", comment: "Description of Welcome Message.")
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let attributedPlaceHolderText = NSMutableAttributedString(string: NSLocalizedString("eMailTextfieldTitle", comment: "Place holder title for button").uppercased())
        attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
        
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.textColor = .white
        textField.attributedPlaceholder = attributedPlaceHolderText
        textField.addBottomBorder(with: UIColor.white, andWidth: 1, offset: 10)
        return textField
    }()
    fileprivate let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("login", comment: "Title of the View.").uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
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
        view.backgroundColor = .systemGray2
        loginButton.layer.cornerRadius = 25
        
        
        self.navigationItem.title =  NSLocalizedString("login", comment: "Title of the View.")
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.titleView?.tintColor = .white
        
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
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
        
    }
}


extension NSMutableAttributedString {
    
    func highlight(color: UIColor, forText stringValue: String, in fontSize: Int) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: CGFloat(fontSize)), range: range)
    }
    
}

extension UIView{
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat, offset: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height + offset, width: frame.size.width, height: borderWidth)
        self.addSubview(border)
    }
}
