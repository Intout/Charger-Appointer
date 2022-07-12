//
//  CitiesViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import UIKit

class CitiesViewController: UIViewController {
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    fileprivate let searchBarView: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: CitiesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }
    
    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("citiesViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        
        view.addSubview(containerView)
        containerView.addSubview(searchBarView)
        
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
        
        // Search Bar View.
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            searchBarView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            searchBarView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
        
        
    }


}
