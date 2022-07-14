//
//  FilterCategoryStackView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import UIKit

class FilterCategoryStackView: UIStackView {

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .init(name: ApplicationFonts.bold.rawValue, size: 20)
        return label
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var data: [any RawRepresentable] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        registerCell()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: [any RawRepresentable]){
        self.data = data
        DispatchQueue.main.async { [unowned self] in
            self.collectionView.reloadData()
        }
    }
    
    private func registerCell(){
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "filterCollectionViewCell")
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
}

extension FilterCategoryStackView: UICollectionViewDelegate{
    
}

extension FilterCategoryStackView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        
        cell.label.text = data[indexPath.item].rawValue as? String
  
        return cell
    }
    
    
}
