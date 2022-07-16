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
            print("Date is not valid!")
        }
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
