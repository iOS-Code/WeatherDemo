//
//  TestAlamofire.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/13.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class TestAlamofire {
    // MARK: - TestCode
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
