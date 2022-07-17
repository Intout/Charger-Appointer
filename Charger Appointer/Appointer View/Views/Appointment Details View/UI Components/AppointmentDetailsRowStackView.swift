//
//  AppointmentDetailsRowStackView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 17.07.2022.
//

import UIKit

class AppointmentDetailsRowStackView: UIStackView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 16)
        label.textColor = .white
        label.text = "Title"
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 16)
        label.textColor = .lightGrey
        label.text = "Description"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = 15
        self.alignment = .fill
        
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(descriptionLabel)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
