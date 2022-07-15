//
//  StationsViewFilterCollectionHelper.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 15.07.2022.
//

import Foundation
import UIKit

class StationsViewFilterCollectionHelper: NSObject{
    
    weak var collectionView: UICollectionView?
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
    
}

extension StationsViewFilterCollectionHelper: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stationsViewCollectionViewCell", for: indexPath) as! StationsViewCollectionViewCell
        cell.label.text = data[indexPath.item].rawValue as? String
        cell.layer.cornerRadius = collectionView.bounds.height / 2
        return cell
    }
}
