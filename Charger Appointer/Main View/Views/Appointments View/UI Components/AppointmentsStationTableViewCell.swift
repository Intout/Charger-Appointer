//
//  AppointmentsStationTableViewCell.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 11.07.2022.
//

import UIKit

class AppointmentsTableViewCell: StationTableViewCell{
    
    fileprivate lazy var dateHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    fileprivate lazy var detailsHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        return stackView
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        // Holder data
        label.text = "Today, 8.00"
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var estimateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        // Holder data
        label.text = "30 min. before"
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var socketNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var chargerTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        // Holder Data
        label.text =  "DC"
        return label
    }()
    
    fileprivate lazy var dateContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey.withAlphaComponent(0.75)
        view.layer.cornerRadius = 5.0
        //view.dropShadow(radius: 1, opacity: 0.25, offset: CGSize(width: 0, height: 5))
        
        return view
    }()
    
    fileprivate lazy var detailsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey.withAlphaComponent(0.75)
        view.layer.cornerRadius = 5.0
        //view.dropShadow(radius: 1, opacity: 0.25, offset: CGSize(width: 0, height: 5))
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateContainerView.addSubview(dateHStack)
        detailsContainerView.addSubview(detailsHStack)
        
        dateHStack.addArrangedSubview(dateLabel)
        dateHStack.addArrangedSubview(estimateLabel)
        self.verticalStack.addArrangedSubview(dateContainerView)
        
        detailsHStack.addArrangedSubview(socketNumberLabel)
        detailsHStack.addArrangedSubview(chargerTypeLabel)
        self.verticalStack.addArrangedSubview(detailsContainerView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            dateHStack.topAnchor.constraint(equalTo: dateContainerView.topAnchor, constant: 15),
            dateHStack.bottomAnchor.constraint(equalTo: dateContainerView.bottomAnchor, constant: -15),
            dateHStack.leadingAnchor.constraint(equalTo: dateContainerView.leadingAnchor, constant: 15),
            dateHStack.trailingAnchor.constraint(equalTo: dateContainerView.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            detailsHStack.topAnchor.constraint(equalTo: detailsContainerView.topAnchor, constant: 15),
            detailsHStack.bottomAnchor.constraint(equalTo: detailsContainerView.bottomAnchor, constant: -15),
            detailsHStack.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor, constant: 15),
            detailsHStack.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor, constant: -15),
        ])
    }
    
    
}
