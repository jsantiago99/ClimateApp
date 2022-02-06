//
//  WeatherManager.swift
//  Clima
//
//  Created by John Santiago on 2/6/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?&appid=ada16f3dd1810b6545c838bc01761020&units=imperial"
    
    func fetchWeather(cityname: String) {
        let urlString = "\(weatherURL)&q=\(cityname)"
        print(urlString)
    }
}
