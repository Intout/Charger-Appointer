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

extension AuthenticationViewModel{
    func loginButtonEvent(with email: String?, completionHandler: @escaping (String?) -> ()){
        do{
            try postCredentials(with: email ?? "")
            completionHandler(nil)
            appCoordinator?.goToMainPage()
            return
        } catch AuthenticationError.invalidEmail {
            print("inValid")
            completionHandler(NSLocalizedString("EMAIL_NOT_IN_CORRECT_FORM", comment: "Invalid email!"))
            return
        } catch AuthenticationError.badResponse {
            print("Bad Response")
            completionHandler(NSLocalizedString("NOT_FOUND", comment: "Request error!"))
            return
        } catch {
            print("Unknown error!")
            completionHandler("An error occured!")
            return
        }
    }
}
