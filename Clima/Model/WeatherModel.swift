//
//  WeatherModel.swift
//  Clima
//
//  Created by John Santiago on 2/7/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditonID: Int
    let cityName: String
    let temperature : Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String {
        switch conditonID {
            case 200..<300:
                return "cloud.bolt"
                
            case 300..<400:
                return "cloud.drizzle"
                
            case 500..<600:
                return "cloud.rain"
                
            case 600..<700:
                return "cloud.snow"
                
            case 701..<800:
                return "cloud.fog"
            case 800:
                return "sun.max"
                
            case 801..<805:
                return "cloud"
                
            default:
                return "cloud"
                
        }
    }
}
