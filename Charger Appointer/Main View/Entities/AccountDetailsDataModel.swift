//
//  AccountDetailsDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 6.07.2022.
//

import Foundation
import UIKit

enum AccountDetailsError: Error{
    case badResponse
}

class AccountDetailsDataModel{
    private var credentials: AuthenticationResponse!
    private var deviceID = UIDevice.current.identifierForVendor!.uuidString
    let semaphore = DispatchSemaphore(value: 0)
    func setCredentials(_ credentials: AuthenticationResponse){
        self.credentials = credentials
    }
    func getCredentials() -> AuthenticationResponse{
        return self.credentials
    }
    
    func getDeviceID() -> String{
        return deviceID
    }
    
    func logout() throws{
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/logout/\(credentials.userID)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.addValue(credentials.token, forHTTPHeaderField: "token")
        request.httpMethod = "POST"
        var feedback: Error?
        
        URLSession.shared.dataTask(with: request){ [unowned self]  _, response, error in
            guard let error = error, (response as? HTTPURLResponse)?.statusCode == 200 else {
                self.semaphore.signal()
                feedback = error
                return
            }
            self.semaphore.signal()
            return
        }.resume()
        semaphore.wait()
        
        if feedback != nil{
            throw AccountDetailsError.badResponse
        }
        
        return
        
    }
    
}
