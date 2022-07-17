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
        stationsCoordinator.start(credentials: credentials, location: location, for: cityName)
        
    }
    
    func goToDateSelectionView(with data: StationResponseElement, credentails: AuthenticationResponse){
        let viewController = AppointmentDataSelectionViewController()
        viewController.viewModel = AppointmentDateSelectionViewModel()
        viewController.viewModel?.coordinator = self
        viewController.viewModel?.setStationData(data)
        viewController.viewModel?.setCredentials(credentails)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goToAppointmentDetailsView(with selectedSocket: SelectedSocket, on stationData: StationResponseElement, at selectedDate: String, for credentials: AuthenticationResponse){
        let viewController = AppointmetnDetailsViewController()
        viewController.viewModel = AppointmentDetailsViewModel()
        viewController.viewModel?.coordinator = self
        viewController.viewModel.setSelectedSocket(selectedSocket)
        viewController.viewModel.setSelectedDate(selectedDate)
        viewController.viewModel.setCredentials(credentials)
        viewController.viewModel.setStationData(stationData)
        
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func presentDateWarningScreen(vm: AppointmentDateSelectionViewModel){
        let viewContoller = WarningViewController()
        viewContoller.setTitleText(NSLocalizedString("invalidDate", comment: ""))
        viewContoller.setDescriptionText(NSLocalizedString("invalidDateDesc", comment: ""))
        viewContoller.setPrimaryButtonTitleText(NSLocalizedString("edit", comment: ""))
        viewContoller.setSecondaryButtonTitleText(NSLocalizedString("selectToday", comment: ""))
        viewContoller.modalPresentationStyle = .overCurrentContext
        viewContoller.modalTransitionStyle = .crossDissolve
        viewContoller.delegate = vm
        navigationController!.present(viewContoller, animated: true, completion: nil)
    }
}

extension Coordinator where Self: AppointerCoordinator{
    func start(credentials: AuthenticationResponse, location: Coordinate?) {
        goToCitiesView(with: credentials, location: location)
    }
}
