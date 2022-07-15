//
//  StationsViewCollectionViewCell.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import UIKit

class StationsViewCollectionViewCell: UICollectionViewCell {
    
    fileprivate lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: ApplicationFonts.regular.rawValue, size: 14)
        label.textColor = .white
        return label
    }()
    
    fileprivate lazy var crossIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "multiply")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(hStack)
        hStack.addArrangedSubview(label)
        hStack.addArrangedSubview(crossIcon)
        
        self.backgroundColor = .dark
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.primary.cgColor
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor, constant:  10),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  10),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
            
        ])
    }
    
}
