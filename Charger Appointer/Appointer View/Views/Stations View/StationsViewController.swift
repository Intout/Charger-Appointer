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
    
    fileprivate let filterCollectionView: UICollectionView = {
        let viewLayoutFlow = UICollectionViewFlowLayout()
        viewLayoutFlow.scrollDirection = .horizontal
        viewLayoutFlow.estimatedItemSize = CGSize(width: 50, height: 50)
        viewLayoutFlow.minimumLineSpacing = 10
        viewLayoutFlow.minimumInteritemSpacing = 20
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayoutFlow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
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
    
    fileprivate lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonPressed))
        button.tintColor = UIColor.white
        return button
    }()
    
    var viewModel: StationsViewModel!
    private var tableViewHelper: StationViewTableViewHelper?
    private var collectionViewHelper: StationsViewFilterCollectionHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableViewHelper = StationViewTableViewHelper(tableView: tableView, viewModel: viewModel)
        collectionViewHelper = StationsViewFilterCollectionHelper(collectionView: filterCollectionView)
        collectionViewHelper?.delegate = self
        
        viewModel.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }
    
    private func setupUI(){
        self.navigationItem.rightBarButtonItem = filterButton
        self.navigationItem.title = NSLocalizedString("stationsViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        view.addSubview(containerView)
        
        containerView.addSubview(searchBarView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(tableView)
        containerView.addSubview(filterCollectionView)
        
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
            filterCollectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
            filterCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            filterCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 10),
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
    
    func didFilterDataUpdated(_ data: [any RawRepresentable]) {
        filterButton.tintColor = data.isEmpty ? .white : .primary
        collectionViewHelper?.setData(data)
    }
}

private extension StationsViewController{
    @objc func filterButtonPressed(){
        viewModel.filterButtonEvent()
    }
}

private extension StationsViewController{
    func removeFilterCollection(){
        
    }
    
    func addFilterCollection(with data: any RawRepresentable){
        
    }
}


extension StationsViewController: StationsViewFilterCollectionHelperDelegate{
    func didCellSelected(with cellData: any RawRepresentable) {
        viewModel.removeFilterData(for: cellData)
        
    }
}
