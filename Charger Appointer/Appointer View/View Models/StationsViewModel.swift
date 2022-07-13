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
    let distanceInKM: JSONNull?
    let geoLocation: GeoLocation
    let services: [Service]
    let stationName: String
}

enum Service: String, Codable {
    case büfe = "Büfe"
    case otopark = "Otopark"
    case wiFi = "Wi-Fi"
}

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


// MARK: - Socket

enum ChargeType: String, Codable {
    case ac = "AC"
    case dc = "DC"
}

enum PowerUnit: String, Codable {
    case kVa = "kVa"
    case kW = "kW"
}

enum SocketType: String, Codable {
    case chAdeMO = "CHAdeMO"
    case csc = "CSC"
    case type2 = "Type-2"
}

typealias StationResponse = [StationResponseElement]

protocol StationsViewModelDelegate: AnyObject{
    func didDataFetched(_ data: StationResponse?)
    func didDataFetchFailed(_ error: Error?)
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
                self.delegate?.didDataFetched(
                    data.filter{
                        $0.geoLocation.province.lowercased() == getCityName()?.lowercased()
                    }
                )
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

