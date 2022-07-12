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
