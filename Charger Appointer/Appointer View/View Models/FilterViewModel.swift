//
//  FilterViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import Foundation

protocol FilterViewModelDelegate: AnyObject{
    func didDataFetched(isLocationExists: Bool)
}

class FilterViewModel{
    weak var coordinator: StationCoordinator?
    weak var delegate: FilterViewModelDelegate?
    weak var navigationDelegate: StationViewNavigationDelegate?
    private var dataModel = FilterViewDataModel()
    
    func viewDidLoad(){
        self.delegate?.didDataFetched(isLocationExists: getLocationExistence())
    }
    
    func getFilterData() -> FilterData{
        return dataModel.getData()
    }
    
    func setLocationExistence(_ state: Bool){
        dataModel.setLocaiton(state)
    }
    
    func getLocationExistence() -> Bool{
        return dataModel.getLocation() ?? false
    }
    
    func setFilterData(_ data: FilterData?){
        if let data = data{
            dataModel.setData(data)
            var collection: [any RawRepresentable] = data.chargerType
            
            collection += data.service
            collection += data.socketType
            if let distance = data.distance{
                setDistance(Int(distance) == 15 ? nil : distance)
            }
            dataModel.setFilterCollection(collection)
        }
    }
    
    func getFilterCollection() -> [any RawRepresentable]{
        return dataModel.getFilterCollection()
    }
    
    func updateFilterCollection(with filter: any RawRepresentable){
        let isContained = dataModel.getFilterCollection().contains{
            $0.rawValue as? String == filter.rawValue as? String
        }
        if isContained{
            dataModel.setFilterCollection(dataModel.getFilterCollection().filter{
                $0.rawValue as? String != filter.rawValue as? String
            })
        } else {
            var currentFilter = dataModel.getFilterCollection()
            currentFilter.append(filter)
            dataModel.setFilterCollection(currentFilter)
        }
    }
    
}

extension FilterViewModel{
    func filterButtonEvent(){
        navigationDelegate?.didNavigate(data: distributeFilterCollection())
        
        coordinator?.didFilterRequested()
        
    }
    
    private func distributeFilterCollection() -> FilterData?{
        if dataModel.getFilterCollection().isEmpty{
            print("Distance: \(dataModel.getDistance())")
            if dataModel.getDistance() ?? 15.0 < 15.0{
                var filterData = FilterData()
                filterData.distance = getDistance()
                return filterData
            }
            return nil
        }
        
        let filters = dataModel.getFilterCollection()
        var filterData = FilterData()
        print("current distance \(dataModel.getDistance())")
        filterData.distance = dataModel.getDistance()
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
}


extension FilterViewModel{
    func setDistance(_ distance: Double?){
        dataModel.setDistance(distance)
    }
    func getDistance() -> Double?{
        return dataModel.getDistance()
    }

}
