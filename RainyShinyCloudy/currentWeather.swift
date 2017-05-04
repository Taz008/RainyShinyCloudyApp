//
//  currentWeather.swift
//  RainyShinyCloudy
//
//  Created by hemang sharma on 3/27/17.
//  Copyright © 2017 hemang sharma. All rights reserved.
//

import UIKit
import Alamofire

class currentWeather{
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentWeather: Double!
    
    var cityName:String{
        return _cityName
    }
    var date:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = " Today is \(currentDate)"
        return _date
    }
    
    var weatherType: String{
        return _weatherType
    }
    var currentWeather: Double{
        return _currentWeather
    }
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        //Alamofire download data taking place
        Alamofire.request(currentUrls).responseJSON{ response in //get request from server!
            let result = response.result // every request has a response and every response has a result.
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let name = dict["name"] as? String{
                   self._cityName = name.capitalized
                    print(name)
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                        print(main)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = main["temp"] as? Double{
                        let kelvinToFahrenhitePreDiv = (temp * (9/5) - 459.67)
                        let kelvinToFahrenhite = Double(round(10*kelvinToFahrenhitePreDiv/10))
                       self._currentWeather = kelvinToFahrenhite
                        print(temp)
                        
                    }
                }
            }
             completed()
        }
       
    }
}
    

