//
//  StationsViewTableViewCell.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 13.07.2022.
//

import Foundation
import UIKit

class StationsViewTableViewCell: StationTableViewCell{
    
    fileprivate lazy var infoHStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    fileprivate lazy var socketOccupationHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        return stackView
    }()
    
    private(set) lazy var serviceHourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        
        let titleText = NSMutableAttributedString(string: NSLocalizedString("serviceHours", comment: "") + ": ")
        
        titleText.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: titleText.length))
        titleText.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.lightGrey, range: NSRange(location: 0, length: titleText.length))
        
        
        let text = NSMutableAttributedString(string: "24 " + NSLocalizedString("hour", comment: ""))
        
        text.addAttribute(NSMutableAttributedString.Key.font, value: UIFont(name: ApplicationFonts.regular.rawValue, size: 16)!, range: NSRange(location: 0, length: text.length))
        text.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.length))
        
        titleText.append(text)
        label.attributedText = titleText
        return label
    }()
    private(set) lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        label.textColor = .lightGrey
        return label
    }()
    
    private(set) lazy var availableSocketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        return label
    }()
    
    fileprivate lazy var infoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey.withAlphaComponent(0.75)
        view.layer.cornerRadius = 5.0
        //view.dropShadow(radius: 1, opacity: 0.25, offset: CGSize(width: 0, height: 5))
        
        return view
    }()
    
    fileprivate lazy var socketOccupationContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey.withAlphaComponent(0.75)
        view.layer.cornerRadius = 5.0
        //view.dropShadow(radius: 1, opacity: 0.25, offset: CGSize(width: 0, height: 5))
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        infoContainerView.addSubview(infoHStackView)
        socketOccupationContainerView.addSubview(socketOccupationHStackView)
        
        infoHStackView.addArrangedSubview(serviceHourLabel)
        infoHStackView.addArrangedSubview(distanceLabel)
        self.verticalStack.addArrangedSubview(infoContainerView)
        
        socketOccupationHStackView.addArrangedSubview(availableSocketLabel)
        self.verticalStack.addArrangedSubview(socketOccupationContainerView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            infoHStackView.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 15),
            infoHStackView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -15),
            infoHStackView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 15),
            infoHStackView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            socketOccupationHStackView.topAnchor.constraint(equalTo: socketOccupationContainerView.topAnchor, constant: 15),
            socketOccupationHStackView.bottomAnchor.constraint(equalTo: socketOccupationContainerView.bottomAnchor, constant: -15),
            socketOccupationHStackView.leadingAnchor.constraint(equalTo: socketOccupationContainerView.leadingAnchor, constant: 15),
            socketOccupationHStackView.trailingAnchor.constraint(equalTo: socketOccupationContainerView.trailingAnchor, constant: -15),
        ])
    }
    
}
