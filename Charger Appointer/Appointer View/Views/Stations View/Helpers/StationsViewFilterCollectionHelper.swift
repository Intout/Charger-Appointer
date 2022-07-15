//
//  StationsViewFilterCollectionHelper.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import Foundation
import UIKit

protocol StationsViewFilterCollectionHelperDelegate: AnyObject{
    func didCellSelected(with cellData: any RawRepresentable)
}

class StationsViewFilterCollectionHelper: NSObject{
    
    weak var collectionView: UICollectionView?
    weak var delegate: StationsViewFilterCollectionHelperDelegate?
    private var data: [any RawRepresentable] = []
    
    init(collectionView: UICollectionView? = nil) {
        super.init()
        self.collectionView = collectionView
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        register()
    }
    
    private func register(){
        self.collectionView?.register(StationsViewCollectionViewCell.self, forCellWithReuseIdentifier: "stationsViewCollectionViewCell")
    }
    
    func setData(_ data: [any RawRepresentable]){
        self.data = data
        DispatchQueue.main.async { [unowned self] in
            self.collectionView?.reloadData()
        }
    }
    
    
}

extension StationsViewFilterCollectionHelper: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didCellSelected(with: self.data[indexPath.item])
    }
    
}

extension StationsViewFilterCollectionHelper: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Data count: \(data.count)")
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stationsViewCollectionViewCell", for: indexPath) as! StationsViewCollectionViewCell
        cell.label.text = data[indexPath.item].rawValue as? String
        cell.layer.cornerRadius = (collectionView.bounds.height / 2) - 2
        
        return cell
    }
}
