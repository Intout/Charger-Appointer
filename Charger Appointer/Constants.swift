//
//  Constants.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import Foundation

enum ApplicationFonts: String{
    case regular = "Ubuntu-Regular"
    case italic = "Ubuntu-Italic"
    case light = "Ubuntu-Light"
    case bold = "Ubuntu-Bold"
}

enum AppointmentCategory: String, CaseIterable{
    case future = "future"
    case passed = "passed"
}

enum AppointmentScreenState{
    case none
    case list
}

enum SearchBarState{
    case idle
    case found
    case notFound
}

enum Service: String, Codable {
    case büfe = "Büfe"
    case otopark = "Otopark"
    case wiFi = "Wi-Fi"
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
