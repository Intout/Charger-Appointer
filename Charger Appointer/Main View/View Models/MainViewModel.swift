//
//  MainViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 5.07.2022.
//

import Foundation

struct AppointmentViewData{
    let appointmentID: Int
    let socketID: Int
    let stationName: String
    let socketType: SocketType
    let chargerType: ChargeType
    let powerUnit: String
    let power: Int
    let time: String
    let date: String
    let socketCount: Int
    let distanceInKM: Double?
    let province: String
    let state: AppointmentCategory
}

protocol MainViewModelDelegate: AnyObject{
    func dataDidFetched(_ data: [[AppointmentViewData]]?)
    func dataIsNill()
    func dataFetchFailed(with error: Error)
}

class MainViewModel{
    weak var coordinator: MainViewCoordinator?
    weak var delegate: MainViewModelDelegate?
    var dataModel = MainViewDataModel()
    
    func viewDidLoad(){
        print("Main View Loaded")
        fetchData()
    }
    
    func fetchData(){
        dataModel.fetchAppointmentData(){ [unowned self] error, data in
            if let data = data {
                
                if data.isEmpty{
                    delegate?.dataIsNill()
                    return
                }
                
                var viewData: [[AppointmentViewData]] = []
                var futureArray: [AppointmentViewData] = []
                var pastArray: [AppointmentViewData] = []
                print("Appointment Count: \(data.count)")
                for datum in data {
                    print("Appointment Name: \(datum.stationName) and \(datum.time)")
                    let socketID = datum.socketID
                    let sockets = datum.station.sockets
                    let appointedSocket = sockets.first(where: {
                        $0.socketID == socketID
                    })
                    if let appointedSocket = appointedSocket {
                        
                        let appointmentData: AppointmentViewData =  .init(appointmentID: datum.appointmentID,
                                                                          socketID: datum.socketID,
                                                                          stationName: datum.stationName,
                                                                          socketType: appointedSocket.socketType,
                                                                          chargerType: appointedSocket.chargeType,
                                                                          powerUnit: appointedSocket.powerUnit,
                                                                          power: appointedSocket.power,
                                                                          time: datum.time,
                                                                          date: formatDateAndReturnString(datum.date),
                                                                          socketCount: datum.station.socketCount,
                                                                          distanceInKM: datum.station.distanceInKM,
                                                                          province: datum.station.geoLocation.province,
                                                                          state: datum.hasPassed ? .passed : .future)
                        
                        if appointmentData.state == .future{
                            futureArray.append(appointmentData)
                        } else {
                            pastArray.append(appointmentData)
                        }
                        
                    }
                }
                viewData.append(futureArray)
                viewData.append(pastArray)
                print(viewData)
                delegate?.dataDidFetched(viewData)
                return
            } else {
                if let error = error{
                    delegate?.dataFetchFailed(with: error)
                    return
                } else {
                    delegate?.dataIsNill()
                    return
                }
            }
        }
    }
    
    func setCredentials(_ credentials: AuthenticationResponse){
        dataModel.setCredentials(credentials)
    }
    
    func getCredentials() -> AuthenticationResponse{
        dataModel.getCredentials()
    }
    
    private func formatDateAndReturnString(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let appointmentDate = dateFormatter.date(from: date)!
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMM yyyy"
        
        return outputDateFormatter.string(from: appointmentDate)
        
    }
    
    private func calcAppointmentState(with date: String) -> AppointmentCategory{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let appointmentDate = dateFormatter.date(from: date)
        
        
        if appointmentDate! < Date(){
            return .passed
        } else {
            return .future
        }
        
    }
    
}


extension MainViewModel{
    func accountButtonEvent(){
        coordinator?.goToAccountDetailsView(with: getCredentials())
    }
    
    func appointmentButtonEvent(){
        coordinator?.goToCitiesView(with: getCredentials(), location: getLocation())
    }
    
}

extension MainViewModel{
    func setLocation(_ location: Coordinate?){
        dataModel.setLocation(location: location)
    }
    
    func getLocation() -> Coordinate?{
        return dataModel.getLocation()
    }
}

extension MainViewModel{
    func deleteRequested(for id: Int, details: String){
        dataModel.setIDToDelete(id)
        
        (coordinator as! MainViewCoordinator).deleteWarningView(vm: self, details: details)
    }
}

extension MainViewModel: WarningViewControllerDelegate{
    func didPrimaryButtonSelected() {
        if let id = dataModel.getIDToDelete(){
            dataModel.requestDelete(for: id){ [unowned self] error in
                if let error = error{
                    print("Delete failed")
                    print(error)
                } else {
                    self.viewDidLoad()
                }
            }
        }
    }
    
    func didSecondaryButtonSelected() {
        dataModel.setIDToDelete(nil)
    }
    
    
}
