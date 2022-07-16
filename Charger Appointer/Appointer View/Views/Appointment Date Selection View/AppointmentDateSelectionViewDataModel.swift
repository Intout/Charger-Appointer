//
//  AppointmentDataSelectionViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import Foundation

struct AppointmentDateResponse: Codable {
    let stationID: Int
    let stationCode: String
    let sockets: [AppointmentSocket]
    let geoLocation: GeoLocation
    let services: [String]
    let stationName: String
}

struct AppointmentSocket: Codable {
    let socketID: Int
    let day: Day
    let socketType, chargeType: String
    let power, socketNumber: Int
    let powerUnit: String
}

struct Day: Codable {
    let id: Int
    let date: String
    let timeSlots: [TimeSlot]
}

struct TimeSlot: Codable {
    let slot: String
    let isOccupied: Bool
}

struct SelectedSocket{
    var id: String
    var slot: String
}

enum AppointmentDateSelectionViewDataModelError: Error{
    case badResponse
}

class AppointmentDateSelectionViewDataModel{
    
    private var credentials: AuthenticationResponse!
    private var stationData: StationResponseElement!
    private var selectedDate: String = DateController().getCurrentDateInCallFormat()
    private var selectedSocket: SelectedSocket?
    
    func fetchData(completionHandler: @escaping (Error?, AppointmentDateResponse?)->()){
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations/\(getStationData().id)?userID=\(getCredentials().userID)&date=\(getSelectedDate())") else {
            print("http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations/\(getStationData().id)?userID=\(getCredentials().userID)&date=\(getSelectedDate())")
            completionHandler(URLError(.badURL), nil)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.addValue(self.credentials.token, forHTTPHeaderField: "token")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completionHandler(error, nil)
                print("Couldn't fetch appointment data!")
                print(response)
                return
            }
            let responseJSON = try? JSONDecoder().decode(AppointmentDateResponse.self, from: data)
            if let responseJSON = responseJSON{
                completionHandler(nil, responseJSON)
            } else {
                completionHandler(AppointmentDateSelectionViewDataModelError.badResponse, nil)
            }
        }.resume()
        
    }
    
    func setCredentials(_ data: AuthenticationResponse){
        credentials = data
    }
    
    func getCredentials() -> AuthenticationResponse{
        return credentials
    }
    
    func setStationData(_ data: StationResponseElement){
        stationData = data
    }
    
    func getStationData() -> StationResponseElement{
        return stationData
    }
    
    func setSelectedSocket(_ data: SelectedSocket?) {
        selectedSocket = data
    }
    
    func getSelectedSocket() -> SelectedSocket?{
        return selectedSocket
    }
    
    func setSelectedDate(_ data: String){
        selectedDate = data
    }
    
    func getSelectedDate() -> String{
        return selectedDate
    }
    
}
