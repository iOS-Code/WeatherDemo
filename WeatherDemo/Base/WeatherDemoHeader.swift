//
//  WeatherDemoHeader.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/13.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 常量
let M_S_Bounds: CGRect = UIScreen.main.bounds
let M_S_W: CGFloat = M_S_Bounds.size.width
let M_S_H: CGFloat = M_S_Bounds.size.height

// MARK: - 路径
let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

// MARK: - 配色
let kThemeColor = UIColor.init(hexString: "#707070")
let kBackgroundColor = UIColor.init(hexString: "#DBDBDB")
let kBlackColor = UIColor.black
let kWhiteColor = UIColor.white

// MARK: - 通知
let WeatherDemoNotificationName = Notification.Name(rawValue: "WeatherDemoNetworkSuccessfuly")
