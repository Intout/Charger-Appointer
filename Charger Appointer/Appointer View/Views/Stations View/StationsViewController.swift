//
//  StationsViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 13.07.2022.
//

import UIKit

class StationsViewController: UIViewController {

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
    
    fileprivate lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel: StationsViewModel!
    private var tableViewHelper: StationViewTableViewHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        tableViewHelper = StationViewTableViewHelper(tableView: tableView, viewModel: viewModel)
        viewModel.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }
    
    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("stationsViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        view.addSubview(containerView)
        
        containerView.addSubview(searchBarView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.backgroundColor = .clear
        
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
            searchBarView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            searchBarView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            searchBarView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 0),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    private func updateMessageLabel(with name: String){
        let body = NSMutableAttributedString(string: NSLocalizedString("resultsFor", comment: ""))
        body.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: body.length))
        
        let cityName = NSMutableAttributedString(string:"'" + name + "'")
        cityName.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.bold.rawValue, size: 16)!, range: NSRange(location: 0, length: cityName.length))
        
        if Locale.current.languageCode == "tr"{
            cityName.append(NSMutableAttributedString(string: " "))
            cityName.append(body)
            messageLabel.attributedText = cityName
        } else if Locale.current.languageCode == "en"{
            body.append(NSMutableAttributedString(string: " "))
            body.append(cityName)
            messageLabel.attributedText = body
        }
    }

}

extension StationsViewController: StationsViewModelDelegate{
    func didDataFetched(_ data: StationResponse?){
        DispatchQueue.main.async { [unowned self] in
            self.updateMessageLabel(with: viewModel.getCityName() ?? "")
        }
        tableViewHelper?.setData(data)
        
    }
    func didDataFetchFailed(_ error: Error?) {
        print("Data fetch failed on Station view")
    }
}
