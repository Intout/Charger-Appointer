//
//  SearchBarView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import UIKit

class SearchBarView: UIView {
    
    fileprivate lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(searchBar)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
