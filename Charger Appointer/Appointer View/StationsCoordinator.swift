//
//  StationsCoordinator.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 13.07.2022.
//

import Foundation
import UIKit

protocol StationViewNavigationDelegate: AnyObject{
    func didNavigate(data: FilterData?)
}

class StationCoordinator: Coordinator{
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        
    }
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func goToStationsView(with credentials: AuthenticationResponse, location: Coordinate?, for cityName: String){
        let stationsViewController = StationsViewController()
        stationsViewController.viewModel = StationsViewModel()
        stationsViewController.viewModel?.coordinator = self
        stationsViewController.viewModel?.setCredentials(credentials)
        stationsViewController.viewModel?.setLocation(location)
        stationsViewController.viewModel.setCityName(cityName)
        navigationController?.pushViewController(stationsViewController, animated: true)
    }
    
    func goToFilterView(with filterData: FilterData?, isLocationExists: Bool, vm: StationsViewModel){
        let filterViewController = FilterViewController()
        filterViewController.viewModel = FilterViewModel()
        filterViewController.viewModel?.coordinator = self
        filterViewController.viewModel?.navigationDelegate = vm
        filterViewController.viewModel?.setFilterData(filterData)
        filterViewController.viewModel?.setLocationExistence(isLocationExists)
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
}

extension Coordinator where Self: StationCoordinator{
    func start(credentials: AuthenticationResponse, location: Coordinate?, for cityName: String) {
        goToStationsView(with: credentials, location: location, for: cityName)
    }
}

extension StationCoordinator{
    func didFilterRequested(){
        if let index = navigationController?.viewControllers.firstIndex(where: { viewController -> Bool in
            return viewController is FilterViewController
            
        }){
            navigationController?.viewControllers.remove(at: index)
        }
    }
        

}
