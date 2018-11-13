//
//  WeatherResponse.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/12.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import ObjectMapper

class WeatherResponse: Mappable {
    
    var location: String?
    var threeDayForecast:[Forecast]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        location <- map["location"]
        threeDayForecast <- map["three_day_forecast"]
    }
}

class Forecast: Mappable {
    var day: String?
    var temperature: Int?
    var conditions: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        day <- map["day"]
        temperature <- map["temperature"]
        conditions <- map["conditions"]
    }
}
