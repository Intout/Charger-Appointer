//
//  AppCoordinator.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 4.07.2022.
//

import Foundation
import UIKit

protocol Coordinator{
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}

class AppCoordinator: Coordinator{
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
    
    private func goToLoginPage(){
        let authenticationViewController = AuthenticationViewController()
        let authenticationViewModel = AuthenticationViewModel()
        authenticationViewModel.appCoordinator = self
        
        authenticationViewController.viewModel = authenticationViewModel
        navigationController.pushViewController(authenticationViewController, animated: true)
    }
    
}
