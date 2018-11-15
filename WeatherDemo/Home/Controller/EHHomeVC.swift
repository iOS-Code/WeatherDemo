//
//  EHHomeVC.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/12.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class EHHomeVC: UIViewController {

    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    
    @IBOutlet weak var listView: UICollectionView!
    
    @IBOutlet weak var nowTempLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    // MARK: - Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestNetwork()
    }
    
    // MARK: - Network
    func requestNetwork() {
        
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let nowString = dateFormatter.string(from: nowDate)
        
        let todayString = UserDefaults.standard.string(forKey: "today")
        let isLocalData = todayString?.count ?? 0 > 0
        
        if nowString == todayString && isLocalData {
            //读取缓存
            let dic: Dictionary = UserDefaults.standard.dictionary(forKey: "weatherData")!
            self.parseWeatherData(responseDic: dic)
            return;
        }
        
        let url = "http://weatherapi.market.alicloudapi.com/weather/TodayTemperatureByCity"
        let params = ["cityName":"北京"]
        let headers = ["Authorization":"APPCODE 691a8c4d415449ffb69b1a7ac2a4000d"];
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) in
            
            if responseObject.response?.statusCode == 200 {
                // 解析数据
                let dic: Dictionary = self.dataToDictonary(data: responseObject.data!)
                self.parseWeatherData(responseDic: dic)
            }
        }
    }
    
    func parseWeatherData(responseDic:[String:Any]){
        let todayDic: Dictionary = (responseDic["result"] as! [String : Any])["today"] as! [String : Any]
        let futureDic: Dictionary = (responseDic["result"] as! [String : Any])["future"] as! [String : Any]
        print(responseDic)
        
        // 更新本地缓存
        UserDefaults.standard.set(todayDic["date_y"], forKey: "today")
        UserDefaults.standard.set(responseDic, forKey: "weatherData")
        
        // 解析当日
        if let todayModel = WeatherTodayModel.deserialize(from:responseDic , designatedPath: "result.today") {
            // 更新当日数据
            print(todayModel)
        }
        
        // 解析本周
        let futureValueArray = Array(futureDic.values)
        if var weekModelArrray = [WeatherWeekModel].deserialize(from: futureValueArray) {
            weekModelArrray.sort(by: { (model1, model2) -> Bool in
                let date1:Int = Int(model1!.date!) ?? 0
                let date2:Int = Int(model2!.date!) ?? 0
                return date1 < date2
            })
            
            // 更新本周数据
            print(weekModelArrray)
        }
    }
    
    // MARK: - Private
    func dataToDictonary(data:Data) -> Dictionary<String, Any> {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        } catch _ {
            print("Nil")
            return Dictionary()
        }
    }
    
    // MARK: - TestCode
    func testCode() {
        let handyJSONObj = TestHandyJSON.init()
        handyJSONObj.testCode()
        
        let alamofireObj = TestAlamofire.init()
        alamofireObj.testRequest()
    }

}
