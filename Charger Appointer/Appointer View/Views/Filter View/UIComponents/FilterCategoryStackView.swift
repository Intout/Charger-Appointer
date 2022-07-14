//
//  FilterCategoryStackView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import UIKit

protocol FilterCategoryStackViewDelegate: AnyObject{
    func didCellSelected(as type: any RawRepresentable)
}

class FilterCategoryStackView: UIStackView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .init(name: ApplicationFonts.bold.rawValue, size: 20)
        return label
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 50, height: 50)
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 20
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var data: [any RawRepresentable] = []
    var existingFilters: [any RawRepresentable] = []
    weak var delegate: FilterCategoryStackViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 15
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(collectionView)
        registerCell()
        
        
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCells(in existingFilter: [any RawRepresentable]){
        self.existingFilters = existingFilter
        DispatchQueue.main.async { [unowned self] in
            self.collectionView.reloadData()
        }
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
    
}

extension FilterCategoryStackView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didCellSelected(as: data[indexPath.item])
    }
}

extension FilterCategoryStackView: UICollectionViewDataSource{
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
        
        cell.label.text = data[indexPath.item].rawValue as? String
        cell.updateState(as: existingFilters.contains{
            $0.rawValue as? String == data[indexPath.item].rawValue as? String
        } ? .selected : .idle)
        cell.layer.cornerRadius = collectionView.bounds.height / 2
        return cell
    }
    
    
}
