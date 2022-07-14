//
//  FilterViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import Foundation

struct FilterData{
    var chargerType: [ChargeType] = []
    var socketType: [SocketType] = []
    var distance: Double = 15.0
    var service: [Service] = []
}

class FilterViewDataModel{
    private var data = FilterData()
    private var filterCollection: [any RawRepresentable] = []
    private var locationExistance: Bool?
    private var distance = 15.0
    
    func getDistance() -> Double{
        return self.distance
    }
    
    func setDistance(_ distence: Double){
        self.distance = distence
    }
    
    func getData() -> FilterData{
        return self.data
    }
    
    func setData(_ data: FilterData){
        self.data = data
    }
    
    func getFilterCollection() -> [any RawRepresentable]{
        return filterCollection
    }
    
    func setFilterCollection(_ collection: [any RawRepresentable]){
        self.filterCollection = collection
    }
    
    func setLocaiton(_ state: Bool){
        locationExistance = state
    }
    
    func getLocation() -> Bool?{
        return locationExistance
    }
}
