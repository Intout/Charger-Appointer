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
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    fileprivate lazy var appointmentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("makeAppointment", comment: "Title of the View.").uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(appointmentButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    fileprivate var appointmentMessageView: AppointmentScreenMessageView = {
        let view = AppointmentScreenMessageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private  var tableViewHelper: AppointmentTableViewHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewHelper = AppointmentTableViewHelper(with: tableView, in: viewModel)
        viewModel.delegate = self
        
        viewModel.viewDidLoad()
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
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!]
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
    
    private func setupButton(){
        NSLayoutConstraint.activate([
            appointmentButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            appointmentButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            appointmentButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -75),
            appointmentButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupTableView(){
        
        containerView.addSubview(tableView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.backgroundColor = .clear
        
        let dummyViewHeight = CGFloat(40)
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        self.tableView.contentInset = UIEdgeInsets(top: -dummyViewHeight, left: 0, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        containerView.insertSubview(appointmentButton, aboveSubview: tableView)
        setupButton()
    }
    
    private func setupMessageView(){
        containerView.addSubview(appointmentMessageView)
        NSLayoutConstraint.activate([
            appointmentMessageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 70),
            appointmentMessageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            appointmentMessageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        containerView.insertSubview(appointmentButton, aboveSubview: appointmentMessageView)
        setupButton()
    }
}

extension ViewController: MainViewModelDelegate{
    func dataDidFetched(_ data: [AppointmentViewData]?) {
        DispatchQueue.main.async { [unowned self] in
            self.setupTableView()
        }
        tableViewHelper?.setData(data)
    }
    func dataFetchFailed(with error: Error) {
        print("Data Not Fetched!")
        print(error)
        print(error)
    }
    
    func dataIsNill() {
        DispatchQueue.main.async { [unowned self] in
            self.setupMessageView()
        }
        print("Nill")
    }
}

private extension ViewController{
    @objc func buttonPressed(){
        viewModel.accountButtonEvent()
    }
    @objc func appointmentButtonPressed(){
        viewModel.appointmentButtonEvent()
    }
}
