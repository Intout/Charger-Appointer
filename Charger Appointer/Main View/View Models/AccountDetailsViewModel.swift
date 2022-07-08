//
//  AccountDetailsViewModel.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 6.07.2022.
//

import Foundation


protocol AccountDetailsViewModelDelegate: AnyObject{
    func didDataSet(email: String, deviceID: String)
}

class AccountDetailsViewModel{
    
    weak var coordinator: MainViewCoordinator?
    weak var delegate: AccountDetailsViewModelDelegate?
    var dataModel = AccountDetailsDataModel()
    
    func viewDidLoad(){
        let credentials = dataModel.getCredentials()
        delegate?.didDataSet(email: credentials.email, deviceID: dataModel.getDeviceID())
    }
    
    func setCredentials(_ credentials: AuthenticationResponse){
        dataModel.setCredentials(credentials)
    }
    
}

extension AccountDetailsViewModel{
    func logoutButtonEvent(){
        do{
            try dataModel.logout()
            print("Logout Successfull!")
            coordinator?.didLogout()
            return
        } catch AccountDetailsError.badResponse{
            print("Logout Failed!")
        } catch URLError.badURL{
            print("Bad url")
        } catch {
            print("Unknown error!")
        }
    }
}
