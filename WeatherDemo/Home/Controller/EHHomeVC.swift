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
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var listView: UICollectionView!
    
    @IBOutlet weak var nowTempLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    var array:[WeatherWeekModel] = []
    
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
//        print(responseDic)
        
        // 更新本地缓存
        UserDefaults.standard.set(todayDic["date_y"], forKey: "today")
        UserDefaults.standard.set(responseDic, forKey: "weatherData")
        
        // 解析当日
        self.updateHomeVC(responseDic)
//        if let todayModel = WeatherTodayModel.deserialize(from:responseDic , designatedPath: "result.today") {
//            // 更新当日数据
//            print(todayModel)
//        }
        
        // 解析本周
        let futureValueArray = Array(futureDic.values)
        if var weekModelArrray = [WeatherWeekModel].deserialize(from: futureValueArray) {
            weekModelArrray.sort(by: { (model1, model2) -> Bool in
                let date1:Int = Int(model1!.date!) ?? 0
                let date2:Int = Int(model2!.date!) ?? 0
                return date1 < date2
            })
            
            // 更新本周数据
            array = weekModelArrray as! [WeatherWeekModel];
//            print(array as Any)
            self.listView.reloadData()
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
    
    func updateHomeVC(_ response: [String : Any]) {
        
        let data: Dictionary = (response["result"] as! [String : Any])["today"] as! [String : Any]
        let sdData: Dictionary = (response["result"] as! [String : Any])["sk"] as! [String : Any]
        print(data)
        print(sdData)
        
        self.cityLbl.text = data["city"] as? String
        self.weatherLbl.text = data["weather"] as? String
        self.nowTempLbl.text = sdData["temp"] as? String
        
        var timeString: String = data["date_y"] as! String
        timeString.append(" ")
        timeString.append(sdData["time"] as! String)
        timeString.append(" 发布")
        self.timeLbl.text = timeString
        
        self.leftBtn.setTitle(sdData["wind_strength"] as? String, for: UIControl.State.normal)
        self.middleBtn.setTitle(sdData["uv_index"] as? String, for: UIControl.State.normal)
        self.rightBtn.setTitle(sdData["humidity"] as? String, for: UIControl.State.normal)
        
        self.imgView.image = UIImage.init(named: self.checkWeatherImage(name: data["weather"] as! String))
    }
    
    
    func checkWeatherImage(name: String) -> String {
        switch name {
        case "晴转多云":
            return "cloudy"
        case "多云转晴":
            return "sun"
        case "晴":
            return "sun"
        case "阴":
            return "yin"
        case "雪":
            return "snow_s"
        case "雾":
            return "fog"
        case "阵雨":
            return "zhenyu"
        case "雷阵雨":
            return "leizhenyu"
        default:
            return "sun"
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


// MARK: - Extension UICollectionView Delegate
extension EHHomeVC:UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EHWeatherListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EHWeatherListCell", for: indexPath) as! EHWeatherListCell
        cell.loadModel(model: self.array[indexPath.row])
        return cell;
    }
    
    
}
