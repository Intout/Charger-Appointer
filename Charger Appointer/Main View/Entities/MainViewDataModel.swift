//
//  MainViewDataModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 6.07.2022.
//

import Foundation

class MainViewDataModel{
    private var credentials: AuthenticationResponse!
    
    func setCredentials(_ credentials: AuthenticationResponse){
        self.credentials = credentials
    }
    
    func getCredentials() -> (AuthenticationResponse){
        return credentials
    }
    
}
