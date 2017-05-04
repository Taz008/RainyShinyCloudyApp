//
//  Constants .swift
//  RainyShinyCloudy
//
//  Created by hemang sharma on 3/27/17.
//  Copyright © 2017 hemang sharma. All rights reserved.
//

import Foundation
let Base_URL = "http://api.openweathermap.org/data/2.5/weather?"
let latitude = "lat=35"
let logitude = "&lon=139"
let appId = "&appID="
let API_KEY = "3de375396daa4b12cd0bdc9d299df331"

typealias DownloadComplete = () -> () //tells our function when our download is complete 

let currentUrls = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=3de375396daa4b12cd0bdc9d299df331"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=3de375396daa4b12cd0bdc9d299df331"

