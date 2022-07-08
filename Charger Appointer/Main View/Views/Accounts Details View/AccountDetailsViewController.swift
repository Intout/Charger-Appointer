//
//  AccountDetailsViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 6.07.2022.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    
    var viewModel: AccountDetailsViewModel!

    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    fileprivate let detailsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey
        return view
    }()
    
    fileprivate let accountIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Badge")
        return imageView
    }()
    
    fileprivate let detailsCard: DetailsCard = {
        let card = DetailsCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    fileprivate lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("logout", comment: "Title of the View.").uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.layer.cornerRadius = 45/2
        button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }

    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("accountViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .charcoalGrey
        self.navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.backButtonDisplayMode = .minimal
        view.addSubview(containerView)
        containerView.addSubview(accountIcon)
        containerView.addSubview(detailsCard)
        containerView.addSubview(logoutButton)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            accountIcon.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 75),
            accountIcon.heightAnchor.constraint(equalToConstant: 150),
            accountIcon.widthAnchor.constraint(equalToConstant: 150),
            accountIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            detailsCard.topAnchor.constraint(equalTo: accountIcon.bottomAnchor, constant: 25),
            detailsCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            detailsCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            logoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            logoutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -75),
            logoutButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
}


extension AccountDetailsViewController: AccountDetailsViewModelDelegate{
    func didDataSet(email: String, deviceID: String) {
        detailsCard.emailTextLabel.text = email
        detailsCard.deviceIDTextLabel.text = deviceID
    }
}

private extension AccountDetailsViewController{
    @objc func buttonEvent(){
        viewModel.logoutButtonEvent()
    }
}
