//
//  FilterViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import UIKit

class FilterViewController: UIViewController {

    fileprivate let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0)
        return view
    }()
    
    fileprivate lazy var chargerTypeCategory: FilterCategoryStackView = {
        let filterCategoryStackView = FilterCategoryStackView()
        filterCategoryStackView.translatesAutoresizingMaskIntoConstraints = false
        filterCategoryStackView.delegate = self
        filterCategoryStackView.titleLabel.text = NSLocalizedString("chargerType", comment: "")
        filterCategoryStackView.setData(ChargeType.allCases)
        return filterCategoryStackView
    }()
    
    fileprivate lazy var socketTypeCategory: FilterCategoryStackView = {
        let filterCategoryStackView = FilterCategoryStackView()
        filterCategoryStackView.translatesAutoresizingMaskIntoConstraints = false
        filterCategoryStackView.delegate = self
        filterCategoryStackView.titleLabel.text = NSLocalizedString("socketType", comment: "")
        filterCategoryStackView.setData(SocketType.allCases)
        return filterCategoryStackView
    }()
    
    fileprivate lazy var distanceSliderView: FilterSliderStackView = {
        let sliderView = FilterSliderStackView()
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.titleLabel.text = NSLocalizedString("distance", comment: "")
        sliderView.delegate = self
        return sliderView
    }()
    
    fileprivate lazy var serviceCategory: FilterCategoryStackView = {
        let filterCategoryStackView = FilterCategoryStackView()
        filterCategoryStackView.translatesAutoresizingMaskIntoConstraints = false
        filterCategoryStackView.delegate = self
        filterCategoryStackView.titleLabel.text = NSLocalizedString("services", comment: "")
        filterCategoryStackView.setData(Service.allCases)
        return filterCategoryStackView
    }()
    
    fileprivate lazy var cleanButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: NSLocalizedString("clean", comment: "").uppercased(), style: .plain, target: self, action: #selector(cleanButtonPressed))
        
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: ApplicationFonts.regular.rawValue, size: 14)!], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: ApplicationFonts.regular.rawValue, size: 14)!], for: .selected)
        
        button.tintColor = UIColor.white
        
        return button
    }()
    
    fileprivate lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("filterButtonTitle", comment: "Title of the Button.").uppercased(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.init(name: ApplicationFonts.bold.rawValue, size: 14)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    var viewModel: FilterViewModel?
    var filters: [any RawRepresentable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setupUI()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.applyGradient(with: [.gradientEnd, .dark], gradientOrientation: .vertical)
    }
    
    private func setupUI(){
        self.navigationItem.title = NSLocalizedString("stationsViewTitle", comment: "Title of view!")
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = cleanButton
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: ApplicationFonts.bold.rawValue, size: 16)!]
        view.backgroundColor = .charcoalGrey
        view.addSubview(containerView)
        
        containerView.addSubview(chargerTypeCategory)
        containerView.addSubview(socketTypeCategory)
        containerView.addSubview(distanceSliderView)
        containerView.addSubview(serviceCategory)
        containerView.addSubview(filterButton)
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
            chargerTypeCategory.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            chargerTypeCategory.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            chargerTypeCategory.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            chargerTypeCategory.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            socketTypeCategory.topAnchor.constraint(equalTo: chargerTypeCategory.bottomAnchor,constant: 20),
            socketTypeCategory.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            socketTypeCategory.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            socketTypeCategory.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            distanceSliderView.topAnchor.constraint(equalTo: socketTypeCategory.bottomAnchor,constant: 20),
            distanceSliderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            distanceSliderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            distanceSliderView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            serviceCategory.topAnchor.constraint(equalTo: distanceSliderView.bottomAnchor,constant: 20),
            serviceCategory.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            serviceCategory.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            serviceCategory.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 70),
            filterButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -70),
            filterButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -75),
            filterButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

}


extension FilterViewController: SliderDelegate{
    func didSliderValueChanged(_ value: Float) {
        print("Slider value: \(value)")
        if value == 15.0{
            viewModel?.setDistance(nil)
        } else {
            viewModel?.setDistance(Double(value))
        }
    }
}

extension FilterViewController{
    func removeSliderView(){
        DispatchQueue.main.async { [unowned self] in
            self.serviceCategory.topAnchor.constraint(equalTo: self.socketTypeCategory.bottomAnchor, constant: 20).isActive = true
            self.distanceSliderView.removeFromSuperview()
        }
    }
}

extension FilterViewController: FilterCategoryStackViewDelegate{
    func didCellSelected(as type: any RawRepresentable) {
        print("Selected filter: \(type.rawValue)")
        viewModel?.updateFilterCollection(with: type)
        if viewModel != nil{
            chargerTypeCategory.updateCells(in: viewModel!.getFilterCollection())
            socketTypeCategory.updateCells(in: viewModel!.getFilterCollection())
            serviceCategory.updateCells(in: viewModel!.getFilterCollection())
        }
    }
}


extension FilterViewController{
   @objc func filterButtonPressed(){
       viewModel?.filterButtonEvent()
      // self.dismiss(animated: true)
    }
    
    @objc func cleanButtonPressed(){
        viewModel?.cleanButtonEvent()
        if viewModel != nil{
            chargerTypeCategory.updateCells(in: viewModel!.getFilterCollection())
            socketTypeCategory.updateCells(in: viewModel!.getFilterCollection())
            serviceCategory.updateCells(in: viewModel!.getFilterCollection())
        }
    }
    
}

extension FilterViewController: FilterViewModelDelegate{
    func didDataFetched(isLocationExists: Bool) {
        if !isLocationExists{
            removeSliderView()
        }
        
        distanceSliderView.updateSlider(viewModel?.getDistance() ?? 15.0)
        
        chargerTypeCategory.updateCells(in: viewModel!.getFilterCollection())
        socketTypeCategory.updateCells(in: viewModel!.getFilterCollection())
        serviceCategory.updateCells(in: viewModel!.getFilterCollection())
    }
}
