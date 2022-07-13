//
//  MainViewCoordinator.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 5.07.2022.
//

import Foundation
import UIKit

class MainViewCoordinator: Coordinator{
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    weak var viewController: ViewController?
    
    
    init(navgationController: UINavigationController){
        self.navigationController = navgationController
    }
    
    func start() {
        
    }
    
    func goToAppointmentsView(with credentials: AuthenticationResponse, location: Coordinate?){
        let mainViewModel = MainViewModel()
        viewController?.viewModel = mainViewModel
        mainViewModel.setCredentials(credentials)
        mainViewModel.setLocation(location)
        mainViewModel.coordinator = self
    }
    
    func goToAccountDetailsView(with credentials: AuthenticationResponse){
        let accountDetailsViewModel = AccountDetailsViewModel()
        let accountViewController = AccountDetailsViewController()
        accountDetailsViewModel.setCredentials(credentials)
        accountDetailsViewModel.coordinator = self
        accountViewController.viewModel = accountDetailsViewModel
        
        self.navigationController?.pushViewController(accountViewController, animated: true)
    }
    
    func goToCitiesView(with credentials: AuthenticationResponse, location: Coordinate?){
        let appointerCoordinator = AppointerCoordinator(navigationController: navigationController)
        appointerCoordinator.parentCoordinator = self
        self.childCoordinators.append(appointerCoordinator)
        
        appointerCoordinator.start(credentials: credentials, location: location)
    }
    
}

extension Coordinator where Self: MainViewCoordinator{
    func start(credentials: AuthenticationResponse, location: Coordinate?) {
        goToAppointmentsView(with: credentials, location: location)
    }
}

extension MainViewCoordinator{
    func didLogout(){
        parentCoordinator?.didChildFinished(from: self)
        navigationController?.dismiss(animated: true)
    }
}


