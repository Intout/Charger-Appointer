//
//  FilterCollectionViewCell.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import UIKit

enum FilterCollectionViewCellState{
    case selected
    case idle
}

class FilterCollectionViewCell: UICollectionViewCell {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: ApplicationFonts.regular.rawValue, size: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    func updateState(as state: FilterCollectionViewCellState){
        switch state {
        case .selected:
            self.backgroundColor = .dark
            self.layer.borderColor = UIColor.primary.cgColor
        case .idle:
            self.backgroundColor = .clear
            self.layer.borderColor = UIColor.white.cgColor
        }
    }
    
}
