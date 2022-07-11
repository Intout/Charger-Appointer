//
//  ViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: MainViewModel!
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    fileprivate lazy var accountButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(buttonPressed))
        button.tintColor = UIColor.white
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        print("loaded")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }
    
    private func setupUI(){
        
        self.navigationItem.leftBarButtonItem = accountButton
        self.navigationItem.title = NSLocalizedString("mainViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .charcoalGrey
        
        view.addSubview(containerView)
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        //Container View.
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    

}

private extension ViewController{
    @objc func buttonPressed(){
        viewModel.accountButtonEvent()
    }
}
