//
//  ForecastCollectionView.swift
//  Weather
//
//  Created by Christian  Huang on 06/11/18.
//  Copyright © 2018 Christian Huang. All rights reserved.
//

import UIKit

class ForecastCollectionView: UICollectionView {

    var forecastListViewModel = ForecastListViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.register(UINib(nibName: "ForecastCell", bundle: nil), forCellWithReuseIdentifier: "forecastCellIdentifier")
    }

}

//MARK:- ViewModel related
extension ForecastCollectionView {
    func initViewModel() {
        self.dataSource = self
        forecastListViewModel.forecastList.listener = { forecastList in
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
}

//MARK:- UICollectionViewDataSource related
extension ForecastCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastListViewModel.forecastCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCellIdentifier", for: indexPath) as! ForecastCell
        let forecastViewModel = forecastListViewModel.getForecastViewModel(indexPath: indexPath)
        cell.configureCell(forecastViewModel: forecastViewModel, isNow: indexPath.item == 0)
        return cell
    }
}
