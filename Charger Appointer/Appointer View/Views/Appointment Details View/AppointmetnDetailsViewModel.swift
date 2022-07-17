//
//  AppointmetnDetailsViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import Foundation

protocol AppointmentDetailsViewModelDelegate: AnyObject{
    
}

class AppointmentDetailsViewModel{
    
    weak var coordinator: Coordinator?
    weak var delegate: AppointmentDetailsViewModelDelegate?
    private var dataModel: AppointmentDetailsViewDataModel?
    
    func viewDidLoad(){
        
    }
    
}

extension AppointmentDetailsViewModel{
    func setStationData(_ data: StationResponseElement){
        dataModel?.setStationData(data)
    }
    
    func getStationData() -> StationResponseElement?{
        dataModel?.getStationData()
    }
    
    func setCredentials(_ data: AuthenticationResponse){
        dataModel?.setCredentials(data)
    }
    
    func getCredentials() -> AuthenticationResponse?{
        dataModel?.getCredentials()
    }
    
    func setSelectedSocket(_ data: SelectedSocket){
        dataModel?.setSelectedSocket(data)
    }
    
    func getSelectedSocket() -> SelectedSocket?{
        dataModel?.getSelectedSocket()
    }
    
    func setSelectedDate(_ data: String){
        dataModel?.setSelectedDate(data)
    }
    
    func getSelectedDate() -> String?{
        dataModel?.getSelectedDate()
    }
}
