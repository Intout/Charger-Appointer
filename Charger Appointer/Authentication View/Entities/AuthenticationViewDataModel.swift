//
//  AuthenticationViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import Foundation
import UIKit


class AuthenticationViewDataModel{
    
    let deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    func authanticate(with email: String, completionHandler: @escaping (Error?, AuthenticationResponse?)->(Void)){
        
        let json: [String: String] = ["email": email, "deviceUDID": deviceID]
        guard let url = URL(string: "ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login") else {
            completionHandler(URLError.badURL as? Error, nil)
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        
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
                }
            }
            
            return
            
        }.resume()
    }
}
