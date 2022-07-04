//
//  AuthenticationViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 3.07.2022.
//

import Foundation

enum AuthenticationError: Error{
    case invalidEmail
    case badResponse
}

protocol AuthenticationDelegate: AnyObject{
    func didViewLoad()
}

class AuthenticationViewModel: ObservableObject{
    private let dataModel = AuthenticationViewDataModel()
    weak var appCoordinator: AppCoordinator?
    func postCredentials(with email: String) throws{
        
        if !validate(email: email){
            throw AuthenticationError.invalidEmail
        } else {
            dataModel.authanticate(with: email){ error, data in
                if error != nil{
                    print(error)
                    return
                }
                print(data)
                return
            }
        }
    }
    
    
}

extension AuthenticationViewModel{
    private func validate(email: String) -> Bool{
        return Regex().isValidEmail(email)
    }
}
