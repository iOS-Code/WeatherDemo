//
//  EHWeatherListCell.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/14.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import UIKit

class EHWeatherListCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    
    func loadModel(model:WeatherWeekModel) {
        self.titleLbl.text = model.week ?? ""
        self.contentLbl.text = model.temperature ?? ""
    }
}