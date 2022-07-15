//
//  StationsViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 13.07.2022.
//

import Foundation

class StationsViewDataModel{
    
    private var credentials: AuthenticationResponse!
    private var location: Coordinate!
    private var data: StationResponse?
    private var cityName: String?
    private var filterData: FilterData?
    private var searchData: String?
    private var filterCollection: [any RawRepresentable] = []
    
    func getSearchData() -> String?{
        return searchData
    }
    
    func setSearchData(_ searchData: String?){
        self.searchData = searchData
    }
    
    func getFilterCollection() -> [any RawRepresentable]{
        return filterCollection
    }
    
    func setFilterCollection(_ filters: [any RawRepresentable]){
        self.filterCollection = filters
    }
    
    func getFilterData() -> FilterData?{
        return filterData
    }
    
    func setFilterData(_ data: FilterData?){
        self.filterData = data
    }
    
    func setCredentials(_ credentials: AuthenticationResponse){
        self.credentials = credentials
    }
    
    func getCredentials() -> (AuthenticationResponse){
        return credentials
    }
    
    func setCityName(_ name: String){
        cityName = name
    }
    
    func getCityName() -> String?{
        cityName
    }
    
    func getLocation() -> Coordinate?{
        return location
    }
    
    func setLocation(location: Coordinate?) -> Void{
        self.location = location
    }
    
    func fetchData(completionHandler: @escaping (Error?, StationResponse?) -> (Void)){

        var urlString: String
        
        if let currentLocation = location{
            
            urlString = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations?userID=\(credentials.userID)&userLatitude=\(currentLocation.latitude)&userLongitude=\(currentLocation.longitude)"
        } else {
            urlString = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations?userID=\(credentials.userID)"
        }
        guard let url = URL(string: urlString) else {
            print("Bad URL")
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
            
            let responseJSON = try? JSONDecoder().decode(StationResponse.self, from: data)
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

extension StationsViewDataModel{
    func getData() -> StationResponse?{
        return self.data
    }
}
