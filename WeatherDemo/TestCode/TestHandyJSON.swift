//
//  TestHandyJSON.swift
//  WeatherDemo
//
//  Created by 岳琛 on 2018/11/13.
//  Copyright © 2018 KMF-Engineering. All rights reserved.
//

import UIKit
import HandyJSON

class TestHandyJSON {
    
    func testCode() {
        self.testRequest7()
    }
    
    // MARK: - 简单模型
    class BasicTypes: HandyJSON {
        var int:Int = 2
        var doubleOptional:Double?
        var stringImplicitlyUnwrapped: String!
        required init() { }
    }
    
    func testRequest1() {
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = BasicTypes.deserialize(from: jsonString) {
            // …
            print(object.int, object.doubleOptional ?? 0, object.stringImplicitlyUnwrapped as String)
        }
    }
    
    // MARK: - 支持枚举、结构体
    enum AnimalType:String, HandyJSONEnum {
        case Cat = "cat"
        case Dog = "dog"
        case Bird = "bird"
    }
    
    struct Animal:HandyJSON {
        var name: String?
        var type: AnimalType?
    }
    
    func testRequest2() {
        let jsonString = "{\"type\":\"cat\",\"name\":\"Tom\"}"
        if let ani = Animal.deserialize(from: jsonString) {
            print(ani.type?.rawValue ?? "")
        }
    }
    
    // MARK: - 复杂模型
    class BasicAnotherTypes: HandyJSON {
        var bool: Bool = true
        var intOptional: Int?
        var doubleImplicitlyUnwrapped: Double!
        var anyObjectOptional: Any?
        
        var arrayInt: Array<Int> = []
        var arrayStringOptional: Array<String>?
        var setInt: Set<Int>?
        var dictAnyObject: Dictionary<String, Any> = [:]
        
        var nsNumber = 2
        var nsString: NSString?
        
        required init() { }
    }
    
    func testRequest3() {
        let obj = BasicAnotherTypes()
        obj.intOptional = 1
        obj.doubleImplicitlyUnwrapped = 1.1
        obj.anyObjectOptional = "StringValue"
        obj.arrayInt = [1, 2]
        obj.arrayStringOptional = ["a", "b"]
        obj.setInt = [1, 2]
        obj.dictAnyObject = ["key1": 1, "key2": "stringValue"]
        obj.nsNumber = 2
        obj.nsString = "nsStringValue"
        
        let jsonString = obj.toJSONString()
        print(jsonString ?? "")
        if let object = BasicAnotherTypes.deserialize(from: jsonString) {
            print(obj.dictAnyObject)
            print(object.dictAnyObject)
        }
    }
    
    // MARK: - 自定义路径解析
    class Cat: HandyJSON {
        var id: Int64!
        var name: String!
        
        required init() {}
    }
    func testRequest4() {
        let jsonString = "{\"code\":200,\"msg\":\"success\",\"data\":{\"cat\":{\"id\":12345,\"name\":\"Kitty\"}}}"
        
        if let cat = Cat.deserialize(from: jsonString, designatedPath: "data.cat") {
            print(cat.id, cat.name)
        }
    }
    
    // MARK: - 复合模型
    class Component: HandyJSON {
        var aInt: Int?
        var aString: String?
        
        required init() { }
    }
    
    class Composition: HandyJSON {
        var num: Int?
        var comp1: Component?
        var comp2: Component?
        
        required init() { }
    }
    
    func testRequest5() {
        let jsonString = "{\"num\":12345,\"comp1\":{\"aInt\":1,\"aString\":\"aaaaa\"},\"comp2\":{\"aInt\":2,\"aString\":\"bbbbb\"}}"
        print(jsonString)
        
        if let composition = Composition.deserialize(from: jsonString) {
            print(composition.num as Any, composition.comp1?.aInt as Any, composition.comp2?.aInt as Any)
        }
    }
    
    // MARK: - 继承模型
    class AnimalAnotherObj: HandyJSON {
        var id: Int?
        var color: String?
        
        required init() {}
    }
    
    class CatAnotherObj: AnimalAnotherObj {
        var name: String?
        
        required init() {}
    }
    
    func testRequest6() {
        let jsonString = "{\"id\":12345,\"color\":\"black\",\"name\":\"cat\"}"
        
        if let cat = CatAnotherObj.deserialize(from: jsonString) {
            print(cat.name!, cat.id!, cat.color!)
        }
    }
    
    // MARK: - 模型数组
    func testRequest7() {
        let jsonArrayString: String? = "[{\"name\":\"Bob\",\"id\":\"1\"}, {\"name\":\"Lily\",\"id\":\"2\"}, {\"name\":\"Lucy\",\"id\":\"3\"}]"
        if let cats = [CatAnotherObj].deserialize(from: jsonArrayString) {
            cats.forEach({ (cat) in
                // ...
                print(cat?.name as Any)
            })
        }
    }
}
