//
//  AuthenticationViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import Foundation
import UIKit



class AuthenticationViewDataModel{
    
    private let deviceID = UIDevice.current.identifierForVendor!.uuidString
    private var locationCoordinates: Coordinate?
    private var locationController = LocationController()
    
    init(){
        locationController.locationDidChanged = setLocation(location:)
    }
    
    func authanticate(with email: String, completionHandler: @escaping (Error?, AuthenticationResponse?)->(Void)){
        print(deviceID)
        let json: [String: String] = ["email": email, "deviceUDID": deviceID]
        let jsonBody = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login") else {
            completionHandler(URLError.badURL as? Error, nil)
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else{
                completionHandler(error, nil)
                return
            }
            
            Task{
                let responseJSON = try? JSONDecoder().decode(AuthenticationResponse.self, from: data)
                if let responseJSON = responseJSON {
                    completionHandler(nil, responseJSON)
                    return
                } else {
                    completionHandler(URLError.badServerResponse as? Error, nil)
                    return
                }
            }
            
            return
            
        }.resume()
    }
    
    func getCoordinates() -> Coordinate?{
        return self.locationCoordinates
    }
}

private extension AuthenticationViewDataModel{
    func setLocation(location: Coordinate?) -> Void{
         self.locationCoordinates = location
        print(self.locationCoordinates as Any)
    }
}
