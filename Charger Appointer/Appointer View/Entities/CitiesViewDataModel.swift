//
//  CitiesViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import Foundation

enum CiteisViewDataModelError: Error{
    case badURL
    case badResponse
}

class CitiesViewDataModel{
    
    private var credentials: AuthenticationResponse!
    private var location: Coordinate!
    private var data: [String]?
    
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
    
    func setLocation(location: Coordinate?) -> Void{
        self.location = location
    }
    
    func fetchData(completionHandler: @escaping (Error?, [String]?) -> (Void)){
        guard let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/provinces?userID=\(credentials.userID)") else {
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
            
            let responseJSON = try? JSONDecoder().decode([String].self, from: data)
            if let responseJSON = responseJSON{
                completionHandler(nil, responseJSON)
                self.data = responseJSON
                return
            } else {
                completionHandler(CiteisViewDataModelError.badResponse, nil)
                return
            }
        }.resume()
        return
    }
    
    
    
}

extension CitiesViewDataModel{
    func getData() -> [String]?{
        return self.data
    }
}
