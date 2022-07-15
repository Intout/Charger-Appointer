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
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var tableViewHelper: CitiesViewTableViewHelper?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewHelper = CitiesViewTableViewHelper(tableView: tableView, viewModel: viewModel, didSelectRow: self.didSelectRow(_:))
        viewModel.delegate = self
        searchBarView.searchBar.delegate = self
        viewModel.viewDidLoad()
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
        containerView.addSubview(tableView)
        
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
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
}

extension CitiesViewController: CitiesViewModelDelegate{
    func didDataFetched(_ data: [String]?) {
        tableViewHelper?.setData(data)
    }
    
    func didDataFetchFailed(_ error: Error?) {
        print(error)
    }
}

extension CitiesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let data = viewModel.filterData(searchText)
        if searchText.count == 0 {
            self.searchBarView.updateState(to: .idle)
        } else if data.count > 0{
            self.searchBarView.updateState(to: .found)
        } else {
            self.searchBarView.updateState(to: .notFound)
        }
        tableViewHelper?.setData(viewModel.filterData(searchText), with: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarView.searchBar.resignFirstResponder()
    }
    
}

extension CitiesViewController{
    func didSelectRow(_ cityName: String){
        viewModel.didSelectRow(with: cityName)
    }
}
