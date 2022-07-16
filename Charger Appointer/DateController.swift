//
//  DateController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import Foundation

class DateController{
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    func isDateValid(_ stringDate: String) -> Bool{
        dateFormatter.date(from: stringDate)! >= Date.now
    }
    
    func formatDateForCall(_ stringDate: String) -> String{
        let callDateFormatter = DateFormatter()
        callDateFormatter.dateFormat = "yyyy-MM-dd"
        callDateFormatter.calendar = Calendar(identifier: .iso8601)
        return callDateFormatter.string(from: dateFormatter.date(from: stringDate)!)
    }
    
    func getCurrentDateInCallFormat() -> String{
        let callDateFormatter = DateFormatter()
        callDateFormatter.dateFormat = "yyyy-MM-dd"
        callDateFormatter.calendar = Calendar(identifier: .iso8601)
        return callDateFormatter.string(from: Date.now)
    }
    
}
