//
//  StationsViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 13.07.2022.
//

import Foundation

struct StationResponseElement: Codable {
    let id: Int
    let stationCode: String
    let sockets: [Socket]
    let socketCount, occupiedSocketCount: Int
    let distanceInKM: Double?
    let geoLocation: GeoLocation
    let services: [Service]
    let stationName: String
}

typealias StationResponse = [StationResponseElement]

protocol StationsViewModelDelegate: AnyObject{
    func didDataFetched(_ data: StationResponse?)
    func didDataFetchFailed(_ error: Error?)
    func didFilterDataUpdated(_ data: [any RawRepresentable])
    func didFilterDataUpdateFinished(_ isDataExists: Bool)
}

class StationsViewModel{
    weak var coordinator: StationCoordinator?
    weak var delegate: StationsViewModelDelegate?
    private let dataModel = StationsViewDataModel()
    
    func viewDidLoad(){
        fetchData()
    }

    
    
    func fetchData(){
        dataModel.fetchData(){ [unowned self] error, data in
            
            if let data = data {
                if let searchText = self.dataModel.getSearchData(){
                    if searchText.count > 0{
                        let viewData = filterData(from: data.filter{
                            $0.geoLocation.province.lowercased() == getCityName()?.lowercased() && $0.stationName.lowercased().contains(searchText.lowercased())
                        })
                        self.delegate?.didDataFetched(viewData)

                    }
                } else {
                    let viewData = filterData(from: data.filter{
                        $0.geoLocation.province.lowercased() == getCityName()?.lowercased()
                    })
                    self.delegate?.didDataFetched(viewData)

                }
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

extension StationsViewModel{
    func setLocation(_ location: Coordinate?){
        dataModel.setLocation(location: location)
    }
    
    func getLocation() -> Coordinate?{
        return dataModel.getLocation()
    }
}

extension StationsViewModel{
    func setCityName(_ name: String){
        dataModel.setCityName(name)
    }
    
    func getCityName() -> String?{
        return dataModel.getCityName()
    }
}

private extension StationsViewModel{
    
    func filterData(from data: StationResponse?) -> StationResponse?{
        let stations: StationResponse? = data
        let filterData = dataModel.getFilterData()
        
        
        // If filter doesn't exits, return original data.
        guard let filterData = filterData else {
            print("Filter doesn't exists")
            return stations
        }
        
       return stations?.filter{
           return doExist(for: $0.sockets, in: filterData.chargerType) && doExist(for: $0.sockets, in: filterData.socketType) && $0.distanceInKM ?? 0.0 < filterData.distance ?? .infinity && doServicesExist(for: $0.services, in: filterData.service)
        }
        
        
    }
    
    func doServicesExist(for services: [Service], in filter: [Service]) -> Bool{
        return filter.allSatisfy(services.contains)
    }
    
    func doExist<T>(for sockets: [Socket], in filter: [T]) -> Bool{
        
        var types: [T] = []

        
        if T.self == ChargeType.self{
            for socket in sockets {
                types.append(socket.chargeType as! T)
            }
            return (filter as! [ChargeType]).allSatisfy((types as! [ChargeType]).contains)
        } else if T.self == SocketType.self{
            for socket in sockets {
                types.append(socket.socketType as! T)
            }
            return (filter as! [SocketType]).allSatisfy((types as! [SocketType]).contains)
        }
    
     return false
    }
    
}

extension StationsViewModel{
    func filterButtonEvent(){
        dataModel.setFilterData(updataFilterData())
        coordinator?.goToFilterView(with: dataModel.getFilterData(), isLocationExists: dataModel.getLocation() != nil, vm: self)
    }
}

extension StationsViewModel: StationViewNavigationDelegate{
    func didNavigate(data: FilterData?) {
        dataModel.setFilterData(data)
        generateFilterCollection(filterData: data)
        print(dataModel.getFilterCollection().count)
        delegate?.didFilterDataUpdateFinished(!dataModel.getFilterCollection().isEmpty)
        fetchData()
    }
}

extension StationsViewModel{
    private func generateFilterCollection(filterData: FilterData?){
        if let filterData = filterData{
            var collection: [any RawRepresentable] = filterData.socketType
            collection += filterData.service
            collection += filterData.chargerType
            dataModel.setFilterCollection(collection)
            delegate?.didFilterDataUpdated(collection)
        } else {
            delegate?.didFilterDataUpdated([])
            dataModel.setFilterCollection([])
        }
    }
    
    func removeFilterData(for data: any RawRepresentable){
        if !dataModel.getFilterCollection().isEmpty{
            var filterCollection = dataModel.getFilterCollection()
            filterCollection = filterCollection.filter{
                $0.rawValue as? String != data.rawValue as? String
            }
            dataModel.setFilterCollection(filterCollection)
            dataModel.setFilterData(updataFilterData())
            delegate?.didFilterDataUpdated(dataModel.getFilterCollection())
            self.fetchData()
            delegate?.didFilterDataUpdateFinished(!dataModel.getFilterCollection().isEmpty)
        }
    }
    
    func updataFilterData() -> FilterData?{
        if dataModel.getFilterCollection().isEmpty{
            return nil
        }
        
        let filters = dataModel.getFilterCollection()
        var filterData = FilterData()
        for filter in filters{
            if filter is ChargeType{
                filterData.chargerType.append(filter as! ChargeType)
            } else if filter is SocketType{
                filterData.socketType.append(filter as! SocketType)
            } else if filter is Service {
                filterData.service.append(filter as! Service)
            }
        }
        return filterData
    }
    
    func filterSearchData(by name: String){
        
        dataModel.setSearchData(name.count > 0 ? name : nil)
        fetchData()
    }
    func getDataCount() -> Int{
        return dataModel.getData()?.count ?? 0
    }
    
}
