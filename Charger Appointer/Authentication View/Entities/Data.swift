//
//  Data.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 3.07.2022.
//

import Foundation

struct AuthenticationResponse: Decodable{
    let email: String
    let token: String
    let userID: Int
}
