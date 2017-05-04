//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by hemang sharma on 3/30/17.
//  Copyright © 2017 hemang sharma. All rights reserved.
//

import CoreLocation

class Location{
    static var sharedInstance = Location()
    private init () {}
    
    var latitude: Double!
    var longitude: Double! // like saying i promise there will be value 
    
}
