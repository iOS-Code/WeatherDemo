//
//  EHNetworkManager.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/13.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class EHNetworkManager {
    
    class func requestWeatherData() {
        
        let url = "http://weatherapi.market.alicloudapi.com/weather/TodayTemperatureByCity"
        let params = ["cityName":"北京"]
        let headers = ["Authorization":"APPCODE 691a8c4d415449ffb69b1a7ac2a4000d"];
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) in
            
            if responseObject.response?.statusCode == 200 {
                // Success
//                print("Request: \(String(describing: responseObject.request))")
//                print("Header: \(String(describing: responseObject.request?.allHTTPHeaderFields))")
//                print("Response: \(String(describing: responseObject.response))")
                
//                let defaultData = UserDefaults.standard
//                defaultData.setValue(responseObject.result, forKeyPath: "WeatherData");
                
            } else {
                // Error
                
            }
        }
    }
    
    func testRequest() {
        let url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
        
        Alamofire.request(url).responseObject { (response:DataResponse<WeatherResponse>) in
            print(response)
            
            let weatherResponse = response.result.value
            print(weatherResponse as Any)
            
            if let threeDayForecast = weatherResponse?.threeDayForecast {
                for forecast in threeDayForecast {
                    print(forecast.day as Any)
                    print(forecast.temperature as Any)
                }
            }
        }
    }
    
}
