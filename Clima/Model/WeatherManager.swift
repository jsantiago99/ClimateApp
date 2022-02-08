//
//  WeatherManager.swift
//  Clima
//
//  Created by John Santiago on 2/6/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    //Define url with api
    //APPLE checks if the url is secure thus, https needs to be at the beginning
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=ada16f3dd1810b6545c838bc01761020&units=imperial"
    
    func fetchWeather(cityname: String) {
        //to query an inputted name specify and add it on to the url
        let urlString = "\(weatherURL)&q=\(cityname)"
        //this performs the request to create the session and task to retrieve data through networking
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            //Create a URL session
            let session = URLSession(configuration: .default)
            
            //Give a session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            // Start the Task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
    
    
}
