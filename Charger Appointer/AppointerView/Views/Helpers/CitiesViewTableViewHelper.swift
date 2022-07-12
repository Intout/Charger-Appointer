//
//  CitiesViewTableViewHelper.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import Foundation
import UIKit

class CitiesViewTableViewHelper: NSObject{
    weak var tableView: UITableView?
    weak var viewModel: CitiesViewModel?
    private var data: [String] = []
    
    init(tableView: UITableView? = nil, viewModel: CitiesViewModel? = nil) {
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = .clear
    }
    
    func setData(_ data: [String]?){
        
        self.data = data ?? []
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }
    
}

extension CitiesViewTableViewHelper: UITableViewDelegate{
    
}

extension CitiesViewTableViewHelper: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.item)
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = data[indexPath.item]
        content.textProperties.font = UIFont.init(name: ApplicationFonts.regular.rawValue, size: 14)!
        content.textProperties.color = .lightGrey
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        return cell
    }
    
    
}


