//
//  WarningViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import UIKit

protocol WarningViewControllerDelegate: AnyObject{
    func didPrimaryButtonSelected()
    func didSecondaryButtonSelected()
}

class WarningViewController: UIViewController {

    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey
        return view
    }()
    
    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Badge2")
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 18)
        label.text = "Title"
        label.textColor = .lightGrey
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        label.text = "Descrpition"
        label.textColor = .lightGrey
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Primary Button".uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(primaryButtonSelected), for: .touchUpInside)
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    fileprivate lazy var secondaryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Secondary Button".uppercased(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGrey.cgColor
        button.addTarget(self, action: #selector(secondaryButtonSelected), for: .touchUpInside)
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    weak var delegate: WarningViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.75)
        
        self.view.addSubview(containerView)
        self.containerView.addSubview(iconImageView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(descriptionLabel)
        self.containerView.addSubview(primaryButton)
        self.containerView.addSubview(secondaryButton)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.70),
            containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 70),
            iconImageView.heightAnchor.constraint(equalToConstant: 150),
            iconImageView.widthAnchor.constraint(equalToConstant: 150),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
          //  descriptionLabel.bottomAnchor.constraint(equalTo: primaryButton.topAnchor, constant: -70),
        ])
        
        NSLayoutConstraint.activate([
            primaryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            primaryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            primaryButton.bottomAnchor.constraint(equalTo: secondaryButton.topAnchor, constant: -20),
            primaryButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            secondaryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            secondaryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            secondaryButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -70),
            secondaryButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

}

private extension WarningViewController{
    @objc func primaryButtonSelected(){
        delegate?.didPrimaryButtonSelected()
        self.dismiss(animated: true)
    }
    
   @objc func secondaryButtonSelected(){
        delegate?.didSecondaryButtonSelected()
        self.dismiss(animated: true)
    }
}

extension WarningViewController{
    func setTitleText(_ text: String){
        self.titleLabel.text = text
    }
    func setDescriptionText(_ text: String){
        self.descriptionLabel.text = text
    }
    func setPrimaryButtonTitleText(_ text: String){
        self.primaryButton.setTitle(text.uppercased(), for: .normal)
    }
    func setSecondaryButtonTitleText(_ text: String){
        self.secondaryButton.setTitle(text.uppercased(), for: .normal)
    }
}
