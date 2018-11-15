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
//        self.imgView.image = UIImage.init(named: self.checkWeatherImage(name: ""))
    }
    
    func checkWeatherImage(name: String) -> String {
        switch name {
        case "云":
            <#code#>
        case "晴":
            <#code#>
        case "阴":
            <#code#>
        case "雪":
            <#code#>
        case "雾":
            <#code#>
        case "阵雨":
            <#code#>
        case "雷阵雨":
            <#code#>
        case "cloudy":
            <#code#>
        case "cloudy":
            <#code#>
        case "cloudy":
            <#code#>
        case "cloudy":
            <#code#>
        case "cloudy":
            <#code#>

        case "cloudy":
            <#code#>
        default:
            <#code#>
        }
    }
    
}
