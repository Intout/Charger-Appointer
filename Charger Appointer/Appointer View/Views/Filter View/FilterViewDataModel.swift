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
    
    func getData() -> FilterData{
        return self.data
    }
    
    func setData(_ data: FilterData){
        self.data = data
    }
    
}
