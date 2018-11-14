//
//  WeatherModel.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/12.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import ObjectMapper
import HandyJSON

class WeatherTodayModel: HandyJSON {
    var temperature: String?
    var weather: String?
    var wind: String?
    var week: String?
    var city: String?
    var date_y: String?
    var dressing_index: String?
    var dressing_advice: String?
    var uv_index: String?
    var wash_index: String?
    var travel_index: String?
    var exercise_index: String?
    
    required init() { }
}

class WeatherWeekModel: HandyJSON {
    var temperature: String?
    var weather: String?
    var wind: String?
    var week: String?
    var date: String?
    
    required init() { }
}
