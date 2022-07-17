//
//  AppointmetnDetailsViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import Foundation

protocol AppointmentDetailsViewModelDelegate: AnyObject{
    func didStationDataFetched(address: String, serviceHours: String, distance: String, stationCode: String, services: String)
    func didSocketDataFetched(socketNo: String, chargerType: String, socketType: String, outputPower: String)
    func didAppointmentDataFetched(date: String, hour: String, appointmentLength: String)
}

class AppointmentDetailsViewModel{
    
    weak var coordinator: Coordinator?
    weak var delegate: AppointmentDetailsViewModelDelegate?
    private var dataModel: AppointmentDetailsViewDataModel = AppointmentDetailsViewDataModel()
    
    func viewDidLoad(){
        fetchData()
    }
    
    func fetchData(){
        print("In Data Fetch!")
        if let stationData = getStationData(){
            print("Station Data Exists!")
            delegate?.didStationDataFetched(
                address: stationData.geoLocation.address,
                serviceHours: "24 " + NSLocalizedString("hour", comment: ""),
                distance: (stationData.distanceInKM != nil ? String(Int(stationData.distanceInKM!)) : "- ")  + " Km",
                stationCode: stationData.stationCode,
                services: stationData.services.map{
                    $0.rawValue
                }.joined(separator: ", "))
        }
        
        if let selectedSocket = getSelectedSocket(), let socketData = getStationData()?.sockets.first(where: {
            String($0.socketID) == selectedSocket.id
        }){
            print("Socket Data Exists!")
            delegate?.didSocketDataFetched(
                socketNo: String(socketData.socketNumber),
                chargerType: socketData.chargeType.rawValue,
                socketType: socketData.socketType.rawValue,
                outputPower: String(socketData.power) + " " + socketData.powerUnit)
        }
        
        if let appointmentDate = getSelectedDate(), let selectedSocket = getSelectedSocket(){
            print("Appointment Data Exists!")
            delegate?.didAppointmentDataFetched(date: appointmentDate, hour: selectedSocket.slot, appointmentLength: "1 " + NSLocalizedString("hour", comment: ""))
        }
        
    }
    
}

extension AppointmentDetailsViewModel{
    func setStationData(_ data: StationResponseElement){
        print("Station Setted")
        print(data)
        dataModel.setStationData(data)
    }
    
    func getStationData() -> StationResponseElement?{
        dataModel.getStationData()
    }
    
    func setCredentials(_ data: AuthenticationResponse){
        dataModel.setCredentials(data)
    }
    
    func getCredentials() -> AuthenticationResponse?{
        dataModel.getCredentials()
    }
    
    func setSelectedSocket(_ data: SelectedSocket){
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
