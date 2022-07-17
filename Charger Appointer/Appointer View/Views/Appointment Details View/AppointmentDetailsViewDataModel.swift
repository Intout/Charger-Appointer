//
//  AppointmentDetailsViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import Foundation

class AppointmentDetailsViewDataModel{
    
    private var stationData: StationResponseElement!
    private var credentials: AuthenticationResponse!
    private var selectedSocket: SelectedSocket!
    private var selectedDate: String!
    
    func setStationData(_ data: StationResponseElement){
        stationData = data
    }
    
    func getStationData() -> StationResponseElement{
        stationData
    }
    
    func setCredentials(_ data: AuthenticationResponse){
        credentials = data
    }
    
    func getCredentials() -> AuthenticationResponse{
        credentials
    }
    
    func setSelectedSocket(_ data: SelectedSocket){
        selectedSocket = data
    }
    
    func getSelectedSocket() -> SelectedSocket{
        return selectedSocket
    }
    
    func setSelectedDate(_ data: String){
        selectedDate = data
    }
    
    func getSelectedDate() -> String{
        selectedDate
    }
    
}
