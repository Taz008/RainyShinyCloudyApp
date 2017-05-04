//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by hemang sharma on 3/27/17.
//  Copyright © 2017 hemang sharma. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    @IBOutlet weak var currentWeatherpic: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempertureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var foreCast: Forecast!
    var current_Weather: currentWeather!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
       
        tableView.delegate = self
        tableView.dataSource = self
        current_Weather = currentWeather()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            current_Weather.downloadWeatherDetails {
                self.downloadForeCastData {
                    self.updateMainUI()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    func downloadForeCastData(completed:@escaping DownloadComplete){
        //downloading forecast data
       // let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                            self.forecasts.append(forecast)
                        print(obj)
                        
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()

                }
            }
            completed()
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let foreCast = forecasts[indexPath.row]
            cell.configureCell(forecast: foreCast)
            return cell
        }else{
            return WeatherCell()
        }
        
    }
    func updateMainUI(){
        dateLabel.text = current_Weather.date
        tempertureLabel.text = "\(current_Weather.currentWeather)"
        currentWeatherTypeLbl.text = current_Weather.weatherType
        locationLabel.text = current_Weather.cityName
        currentWeatherpic.image = UIImage(named: current_Weather.weatherType)
        
    }
    



}

