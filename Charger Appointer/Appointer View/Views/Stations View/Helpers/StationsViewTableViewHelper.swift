//
//  StationsViewTableViewHelper.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 13.07.2022.
//

import Foundation
import UIKit


class StationViewTableViewHelper: NSObject{
    weak var tableView: UITableView?
    weak var viewModel: StationsViewModel?
    private var data: StationResponse = []
    
    init(tableView: UITableView? = nil, viewModel: StationsViewModel? = nil) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = .clear
        register()
    }
    
    private func register(){
        tableView?.register(StationsViewTableViewCell.self, forCellReuseIdentifier: "stationsViewTableViewCell")
    }
    
    func setData(_ data: StationResponse?){
        print(data)
        self.data = data ?? []
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }
    
}


extension StationViewTableViewHelper: UITableViewDelegate{
    
}

extension StationViewTableViewHelper: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationsViewTableViewCell", for: indexPath) as! StationsViewTableViewCell
        cell.backgroundColor = .clear
        let stationData = data[indexPath.item]
        cell.titleLabel.text = stationData.stationName
        
        let titleText = NSMutableAttributedString(string: NSLocalizedString("availableSocketCount", comment: "") + ": ")
        
        titleText.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: titleText.length))
        titleText.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.lightGrey, range: NSRange(location: 0, length: titleText.length))
        
        let text = NSMutableAttributedString(string: "\(stationData.socketCount)/3")
        
        text.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: text.length))
        text.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.length))
        titleText.append(text)
        cell.availableSocketLabel.attributedText = titleText
            
     return cell
    }
}