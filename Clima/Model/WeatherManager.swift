//
//  WeatherManager.swift
//  Clima
//
//  Created by John Santiago on 2/6/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    //Define url with api
    //APPLE checks if the url is secure thus, https needs to be at the beginning
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=ada16f3dd1810b6545c838bc01761020&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityname: String) {
        //to query an inputted name specify and add it on to the url
        let urlString = "\(weatherURL)&q=\(cityname)"
        //this performs the request to create the session and task to retrieve data through networking
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // Create URL
        if let url = URL(string: urlString) {
            
            //Create a URL session
            let session = URLSession(configuration: .default)
            
            //Give a session a task
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // Start the Task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditonID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
