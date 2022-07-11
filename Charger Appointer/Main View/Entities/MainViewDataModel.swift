//
//  MainViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 6.07.2022.
//

import Foundation
import CoreLocation


enum MainDataModelError: Error{
    case badURL
    case badResponse
}

class MainViewDataModel{
    private var credentials: AuthenticationResponse!
    private var location: Coordinate?
    
    func setCredentials(_ credentials: AuthenticationResponse){
        self.credentials = credentials
    }
    
    func getCredentials() -> (AuthenticationResponse){
        return credentials
    }
    
    func getLocation() -> Coordinate?{
        print(location as Any)
        return location
    }
    
    func fetchAppointmentData(completionHandler: @escaping (Error?, [AppointmentResponseElement]?)->(Void)){
        
        var urlString: String
        
        if let currentLocation = location{
            urlString = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/\(credentials.userID)?userL atitude=\(currentLocation.latitude)&userLongitude=\(currentLocation.longitude)"
        } else {
            urlString = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/\(credentials.userID)"
        }
        guard let url = URL(string: urlString) else {
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
                return
            }
            
            let responseJSON = try? JSONDecoder().decode(AppointmentResponse.self, from: data)
            if let responseJSON = responseJSON{
                completionHandler(nil, responseJSON)
                return
            } else {
                completionHandler(MainDataModelError.badResponse, nil)
                return
            }
        }.resume()
        return
    }
    
    
    
}

extension MainViewDataModel{
    func setLocation(location: Coordinate?) -> Void{
       // self.location = location
    }
}
