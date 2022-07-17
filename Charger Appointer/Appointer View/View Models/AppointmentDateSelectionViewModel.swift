//
//  AppointmentDataSelectionViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import Foundation

protocol AppointmentDateSelectionViewModelDelegate: AnyObject{
    func didDataFetch(_ data: [AppointmentSocket])
    func didDataFetchFailed(_ error: Error?)
    func didDateEditSelected()
    func didTodayDateSelected()
}

class AppointmentDateSelectionViewModel{
    private var dataModel = AppointmentDateSelectionViewDataModel()
    weak var delegate: AppointmentDateSelectionViewModelDelegate?
    weak var coordinator: Coordinator?
    
    
    func viewDidLoad(){
        fetchData()
    }
    
    private func fetchData(){
        dataModel.fetchData{ [unowned self] error, data in
            if let data = data{
                self.delegate?.didDataFetch(data.sockets)
            } else {
                self.delegate?.didDataFetchFailed(error)
            }
        }
    }
    
    func updateDate(with date: String){
        if DateController().isDateValid(date){
            dataModel.setSelectedDate(DateController().formatDateForCall(date))
            fetchData()
        } else {
            (coordinator as! AppointerCoordinator).presentDateWarningScreen(vm: self)
            print("Date is not valid!")
        }
    }
    
    private func setDateToToday(){
        dataModel.setSelectedDate(DateController().getCurrentDateInCallFormat())
        fetchData()
    }
    
}

extension AppointmentDateSelectionViewModel{
    
    func setCredentials(_ data: AuthenticationResponse){
        dataModel.setCredentials(data)
    }
    
    func getCredentials() -> AuthenticationResponse?{
        return dataModel.getCredentials()
    }
    
    func setStationData(_ data: StationResponseElement){
        dataModel.setStationData(data)
    }
    
    func getStationData() -> StationResponseElement?{
        dataModel.getStationData()
    }
    
    func setSelectedSocket(_ data: SelectedSocket?) {
        dataModel.setSelectedSocket(data)
    }
    
    func getSelectedSocket() -> SelectedSocket?{
        dataModel.getSelectedSocket()
    }
    
    func setSelectedDate(_ data: String){
        dataModel.setSelectedDate(data)
    }
    
    func getSelectedDate() -> String?{
        dataModel.getSelectedDate()
    }
    
    
}

extension AppointmentDateSelectionViewModel{
    func continueButtonEvent(){
         
         if getSelectedSocket() != nil && getStationData() != nil && getSelectedDate() != nil && getCredentials() != nil{
             (coordinator as! AppointerCoordinator).goToAppointmentDetailsView(with: getSelectedSocket()!, on: getStationData()!, at: getSelectedDate()!, for: getCredentials()!)
        }
        
        
    }
}

extension AppointmentDateSelectionViewModel: WarningViewControllerDelegate{
    func didPrimaryButtonSelected() {
        delegate?.didDateEditSelected()
    }
    func didSecondaryButtonSelected() {
        setDateToToday()
        delegate?.didTodayDateSelected()
    }
}
