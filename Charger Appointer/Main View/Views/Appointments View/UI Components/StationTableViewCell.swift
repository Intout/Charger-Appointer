//
//  StationTableViewCell.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 11.07.2022.
//

import UIKit

protocol StationTableViewCellDelegate: AnyObject{
    func didDeleteRequested(for id: Int)
}

class StationTableViewCell: UITableViewCell {

    fileprivate lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.charcoalGrey.withAlphaComponent(0.5)
        view.layer.cornerRadius = 5.0
        
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ApplicationFonts.bold.rawValue, size: 20)
        label.textColor = .white
        // Holder data
        label.text = "Holder Title"
        return label
    }()
    
    private(set) lazy var chargerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        // Holder data
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .center
        // Given assets are not centered!
        imageView.transform = CGAffineTransform(translationX: 0, y: 6)
        return imageView
    }()
    
    private(set) lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .lightGrey
        
        return button
    }()
    
    private(set) lazy var verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 10
       // stackView.layoutMargins = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    fileprivate lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var id: Int!
    weak var delegate: StationTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(containerView)
        containerView.addSubview(verticalStack)
        titleContainerView.addSubview(chargerImage)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(didButtonPressed), for: .touchUpInside)
        verticalStack.addArrangedSubview(titleContainerView)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            chargerImage.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            chargerImage.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            chargerImage.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: chargerImage.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
            deleteButton.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo:  self.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo:  self.trailingAnchor, constant: -10),
        
            
        ])
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            verticalStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            verticalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            chargerImage.heightAnchor.constraint(equalToConstant: 40),
            chargerImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

private extension StationTableViewCell{
    @objc func didButtonPressed(){
        print(id)
        print("Button Pressed")
        delegate?.didDeleteRequested(for: id)
    }
}
