//
//  AppointmentsTableViewHelper.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 11.07.2022.
//

import Foundation
import UIKit

class AppointmentTableViewHelper: NSObject{
    
    weak var tableView: UITableView?
    weak var viewModel: MainViewModel?
    
    init(with tableView: UITableView, in vm: MainViewModel) {
        super.init()
        self.viewModel = vm
        self.tableView = tableView
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self

        register()
    }
    
    private func register(){
        tableView?.register(AppointmentsTableViewCell.self, forCellReuseIdentifier: "appointmentsTableViewCell")
    }
    
    
}

extension AppointmentTableViewHelper: UITableViewDelegate{

}

extension AppointmentTableViewHelper: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableViewCell", for: indexPath) as! AppointmentsTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
}
