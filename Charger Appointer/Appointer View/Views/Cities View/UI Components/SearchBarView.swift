//
//  SearchBarView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 12.07.2022.
//

import UIKit

class SearchBarView: UIView {
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = .default
        if let textField = searchBar.value(forKey: "searchField") as? UITextField{
            textField.backgroundColor = .dark
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = 20
            textField.leftView?.tintColor = .lightGrey
            textField.rightView?.tintColor = .lightGrey
            textField.layer.borderColor = UIColor.lightGrey.cgColor
            textField.layer.borderWidth = 1
            
            let attributedPlaceHolderText = NSMutableAttributedString(string: NSLocalizedString("citiesSearchBarPlaceHolder", comment: "Place holder title for button"))
            attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor.lightGrey, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
            attributedPlaceHolderText.addAttribute(NSMutableAttributedString.Key.font, value: UIFont.init(name: ApplicationFonts.light.rawValue, size: 12)!, range: NSRange(location: 0, length: attributedPlaceHolderText.length))
            
            textField.font = UIFont.init(name: ApplicationFonts.light.rawValue, size: 16)
            textField.textColor = .white
            textField.attributedPlaceholder = attributedPlaceHolderText
            textField.addBottomBorder(with: UIColor.lightGrey, andWidth: 1, offset: 10)
            textField.keyboardAppearance = .default
            
        }
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.endEditing(true)
        return searchBar
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(searchBar)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    func updateState(to state: SearchBarState){
        switch state {
        case .idle:
            searchBar.searchTextField.layer.borderColor = UIColor.lightGrey.cgColor
        case .found:
            searchBar.searchTextField.layer.borderColor = UIColor.primary.cgColor
        case .notFound:
            searchBar.searchTextField.layer.borderColor = UIColor.state.cgColor
        }
    }
    
}
