//
//  CitiesViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import Foundation

protocol CitiesViewModelDelegate: AnyObject{
    func didDataFetched(_ data: [String]?)
    func didDataFetchFailed(_ error: Error?)
}

class CitiesViewModel{
    
    weak var coordinator: AppointerCoordinator?
    weak var delegate: CitiesViewModelDelegate?
    private let dataModel = CitiesViewDataModel()
    
    
    func viewDidLoad(){
        fetchData()
    }
    
    func fetchData(){
        dataModel.fetchData(){ [unowned self] error, data in
            
            if let data = data {
                self.delegate?.didDataFetched(data)
            } else {
                self.delegate?.didDataFetchFailed(error)
            }
        }
    }
    
    func setCredentials(_ credentials: AuthenticationResponse){
        dataModel.setCredentials(credentials)
    }
    
    func getCredentials() -> AuthenticationResponse{
        dataModel.getCredentials()
    }
    
}

extension CitiesViewModel{
    func setLocation(_ location: Coordinate?){
        dataModel.setLocation(location: location)
    }
    
    func getLocation() -> Coordinate?{
        return dataModel.getLocation()
    }
}

extension CitiesViewModel{
    func filterData(_ searchText: String) -> [String]{
        if searchText.count > 0{
            return dataModel.getData()?.filter{
                $0.lowercased().contains(searchText.lowercased())
            } ?? []
        } else {
            return dataModel.getData() ?? []
        }
    }
}

extension CitiesViewModel{
    func didSelectRow(with cityName: String){
        coordinator?.goToStationsView(with: getCredentials(), location: getLocation(), for: cityName)
    }
}
