//
//  MainViewCoordinator.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 5.07.2022.
//

import Foundation
import UIKit

class MainViewCoordinator: Coordinator{
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    weak var navigationController: UINavigationController?
    weak var viewController: ViewController?
    
    init(navgationController: UINavigationController){
        self.navigationController = navgationController
    }
    
    func start() {
        let mainViewModel = MainViewModel()
        
        viewController?.viewModel = mainViewModel
        
    }
    
    
}
