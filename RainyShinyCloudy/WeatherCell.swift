//
//  TableViewCell.swift
//  RainyShinyCloudy
//
//  Created by hemang sharma on 3/29/17.
//  Copyright © 2017 hemang sharma. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    
    func configureCell(forecast: Forecast){
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }


}
