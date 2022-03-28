//
//  MainWeatherViewModel.swift
//  StarWarsWeather v2
//
//  Created by Alex Peterson on 3/25/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @ObservedObject var weatherData: WeatherModel
    
    init(){
        weatherData = WeatherModel(conditionId: 1, cityName: "Columbia", temperature: 10.0, description: "Great Weather")
    }
    
    func updateWeather(newWeatherData: WeatherModel) {
        weatherData = newWeatherData
    }
}
