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
        self.imgView.image = UIImage.init(named: self.checkWeatherImage(name: model.weather!))
//        print(model.week!, model.weather!)
    }
    
    func checkWeatherImage(name: String) -> String {
        switch name {
        case "晴转多云":
            return "cloudy_s"
        case "多云转晴":
            return "sun_s"
        case "晴":
            return "sun_s"
        case "阴":
            return "yin_s"
        case "雪":
            return "snow_s_s"
        case "雾":
            return "fog_s"
        case "阵雨":
            return "zhenyu_s"
        case "雷阵雨":
            return "leizhenyu_s"
        default:
            return "sun_s"
        }
    }
    
}
