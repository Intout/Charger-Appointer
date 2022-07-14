//
//  FilterViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import Foundation

protocol FilterViewModelDelegate: AnyObject{
    
}

class FilterViewModel{
    weak var coordinator: StationCoordinator?
    weak var delegate: FilterViewModelDelegate?
    private var dataModel = FilterViewDataModel()
    
    func getFilterData() -> FilterData{
        return dataModel.getData()
    }
    
    func setFilterData(_ data: FilterData?){
        if let data = data{
            dataModel.setData(data)
        }
    }
    
    func updateChargerType(with type: ChargeType){
        var filterData = dataModel.getData()
        var chargerType = filterData.chargerType
        if chargerType.contains(type){
            chargerType = chargerType.filter{
                $0 != type
            }
        } else {
            chargerType.append(type)
        }
        filterData.chargerType = chargerType
        dataModel.setData(filterData)
    }
    
    
}
