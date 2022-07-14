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
    private var data: [AppointmentViewData] = []
    private var categoryTags: [AppointmentCategory] = [.future, .passed]
    
    
    init(with tableView: UITableView, in vm: MainViewModel) {
        super.init()
        self.viewModel = vm
        self.tableView = tableView
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self

        register()
    }
    
    func setData(_ viewData: [AppointmentViewData]?){
        if let viewData = viewData {
            self.data = viewData
            DispatchQueue.main.async { [unowned self] in
                self.tableView?.reloadData()
            }
            
        }
    }
    
    private func register(){
        tableView?.register(AppointmentsTableViewCell.self, forCellReuseIdentifier: "appointmentsTableViewCell")
    }
    
    
}

extension AppointmentTableViewHelper: UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryTags.count
    }
    /*
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return categoryTags.map{
            NSLocalizedString($0.rawValue, comment: "Section Title")
        }
    }
    */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let label = UILabel(frame: CGRect(x: 10, y: -10, width: tableView.frame.width, height: 20))
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 16)
        label.textColor = .lightGrey
        label.text =  NSLocalizedString(categoryTags[section].rawValue, comment: "Section Title")
        view.addSubview(label)
        return view
    }
    
}

extension AppointmentTableViewHelper: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tag = categoryTags[section]
        print(tag)
        print(data.map{
            return $0.state == tag
        })
        return data.filter{
            return $0.state == tag
        }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentsTableViewCell", for: indexPath) as! AppointmentsTableViewCell
        cell.backgroundColor = .clear
        
        let cellData = data[indexPath.item]
        
        cell.titleLabel.text = cellData.stationName + ", " + cellData.province
        
        cell.dateLabel.text = cellData.date + ", " + cellData.time
        cell.estimateLabel.text = String(cellData.power) + " " + cellData.powerUnit
    
        
        let title = NSMutableAttributedString(string: NSLocalizedString("socketNumber", comment: "Socket no.") + ": ")
        title.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.lightGrey, range: NSRange(location: 0, length: title.length))
        title.addAttribute(NSMutableAttributedString.Key.font, value: UIFont.init(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: title.length))
        
        let socketNumber = NSMutableAttributedString(string: String(cellData.socketID))
        socketNumber.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: socketNumber.length))
        socketNumber.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: socketNumber.length))
        title.append(socketNumber)
        
        cell.socketNumberLabel.attributedText = title
        
        cell.chargerTypeLabel.text = cellData.chargerType.rawValue
        
        return cell
    }
    

}
