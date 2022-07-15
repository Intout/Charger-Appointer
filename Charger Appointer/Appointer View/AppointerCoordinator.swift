//
//  AppointerCoordinator.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import Foundation
import UIKit


class AppointerCoordinator: Coordinator{
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        
    }
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func goToCitiesView(with credentials: AuthenticationResponse, location: Coordinate?){
        let citiesViewController = CitiesViewController()
        citiesViewController.viewModel = CitiesViewModel()
        citiesViewController.viewModel.setCredentials(credentials)
        citiesViewController.viewModel.setLocation(location)
        citiesViewController.viewModel.coordinator = self
        navigationController?.pushViewController(citiesViewController, animated: true)
    }
    
    func goToStationsView(with credentials: AuthenticationResponse, location: Coordinate?, for cityName: String){
        let  stationsCoordinator = StationCoordinator(navigationController: self.navigationController)
        stationsCoordinator.parentCoordinator = self
        self.childCoordinators.append(stationsCoordinator)
        self.childCoordinators.count
        stationsCoordinator.start(credentials: credentials, location: location, for: cityName)
        
    }
    
}

extension Coordinator where Self: AppointerCoordinator{
    func start(credentials: AuthenticationResponse, location: Coordinate?) {
        goToCitiesView(with: credentials, location: location)
    }
}
