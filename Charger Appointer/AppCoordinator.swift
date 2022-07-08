//
//  AppCoordinator.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 4.07.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject{
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController? {get set}
    
    func start()
}

extension Coordinator{
    func didChildFinished(from child: Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return coordinator === child
        }){
            childCoordinators.remove(at: index)
        }
        
    }
}

class AppCoordinator: Coordinator{
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
    
    private func goToLoginPage(){
        let authenticationViewController = AuthenticationViewController()
        let authenticationViewModel = AuthenticationViewModel()
        parentCoordinator = self
        authenticationViewModel.appCoordinator = self
        authenticationViewController.viewModel = authenticationViewModel
        navigationController?.pushViewController(authenticationViewController, animated: true)
    }
    
    func goToMainPage(credentials: AuthenticationResponse){
        let mainViewController = ViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        mainNavigationController.modalPresentationStyle = .currentContext
       
        let mainViewCoordinator = MainViewCoordinator(navgationController: mainNavigationController)
        
        mainViewCoordinator.viewController = mainViewController
        mainViewCoordinator.parentCoordinator = self
        mainViewCoordinator.start(credentials: credentials)
        
        self.childCoordinators.append(mainViewCoordinator)
        navigationController?.present(mainNavigationController, animated: true, completion: nil)
    }
}
