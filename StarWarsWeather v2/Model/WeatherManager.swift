////
////  WeatherManager.swift
////  Star Wars Weather
////
////  Created by Alex Peterson on 02/04/2021.
////  Copyright © 2021 Alex S Peterson. All rights reserved.
////

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=67b46e25235af20a6152a33263f69817&units=imperial"

    func peformRequest(urlstring: String, completion: @escaping (WeatherModel) -> Void) {
        //1. Create a URL
        if let url = URL(string: urlstring){

            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
//                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        completion(weather)
//                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }

    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description)
            return weather
        } catch {
            print(error)
//            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}

extension WeatherManager {
    func fetchWeather(cityName: String) -> WeatherModel? {
        let urlString = "\(weatherURL)&q=\(cityName)"
        var newWeatherModel: WeatherModel?
        peformRequest(urlstring: urlString) { model in
            newWeatherModel = model
        }
        return newWeatherModel
    }
    
    func fetchWeather(latitude: Double, longitude: Double) -> WeatherModel? {
        let urlString = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        var newWeatherModel: WeatherModel?
        peformRequest(urlstring: urlString) { model in
            newWeatherModel = model
        }
        return newWeatherModel
    }
}
