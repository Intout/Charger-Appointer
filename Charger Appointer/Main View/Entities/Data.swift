//
//  Data.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 11.07.2022.
//

import Foundation

// MARK: - AppointmentResponseElement
struct AppointmentResponseElement: Codable {
    let time, date: String
    let station: Station
    let stationCode, stationName: String
    let userID, appointmentID, socketID: Int
    let hasPassed: Bool
}

// MARK: - Station
struct Station: Codable {
    let id: Int
    let stationCode: String
    let sockets: [Socket]
    let socketCount, occupiedSocketCount: Int
    let distanceInKM: Double?
    let geoLocation: GeoLocation
    let services: [String]
    let stationName: String
}

// MARK: - GeoLocation
struct GeoLocation: Codable {
    let longitude, latitude: Double
    let province, address: String
}

// MARK: - Socket
struct Socket: Codable {
    let socketID: Int
    let socketType, chargeType: String
    let power: Int
    let powerUnit: String
    let socketNumber: Int
}

typealias AppointmentResponse = [AppointmentResponseElement]
