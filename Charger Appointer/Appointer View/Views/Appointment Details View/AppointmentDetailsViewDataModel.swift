//
//  AppointmentDetailsViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import Foundation

enum AppointmentDetailsViewDataModelError{
    case badResponse
}

class AppointmentDetailsViewDataModel{
    
    private var stationData: StationResponseElement!
    private var credentials: AuthenticationResponse!
    private var selectedSocket: SelectedSocket!
    private var selectedDate: String!
    
    func requestAppointment(completionHandler: @escaping (Error?)->()){
        
        let json: [String: Any] =
        [
            "stationID": stationData.id,
            "socketID": Int(selectedSocket.id)!,
            "timeSlot": selectedSocket.slot,
            "appointmentDate": selectedDate!,
        ]
        
        let jsonBody = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/make?userID=\(credentials.userID)") else {
            completionHandler(URLError(.badURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonBody
        request.addValue(credentials.token, forHTTPHeaderField: "token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard data == data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else{
                completionHandler(error)
                print(response)
                return
            }
            completionHandler(nil)
            return
            
        }.resume()
        
        
    }
    
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
