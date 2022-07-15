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
    private var searchText: String = ""
    var didSelectRow: (String) -> ()
    
    init(tableView: UITableView? = nil, viewModel: CitiesViewModel? = nil, didSelectRow: @escaping (String) -> ()) {
        self.didSelectRow = didSelectRow
        super.init()
        self.tableView = tableView
        self.viewModel = viewModel
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = .clear
    }
    
    func setData(_ data: [String]?){
        
        self.data = data ?? []
        self.searchText = ""
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }
    
    func setData(_ data: [String]?, with searchText: String){
        self.data = data ?? []
        self.searchText = searchText
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }
    
}

extension CitiesViewTableViewHelper: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(data[indexPath.item])
    }
}

extension CitiesViewTableViewHelper: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let attuributedText = NSMutableAttributedString(string: data[indexPath.item])
        attuributedText.highlight(color: .white, forText: self.searchText, in: 14)
        content.attributedText = attuributedText
        content.textProperties.font = UIFont.init(name: ApplicationFonts.regular.rawValue, size: 14)!
        content.textProperties.color = .lightGrey
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}


