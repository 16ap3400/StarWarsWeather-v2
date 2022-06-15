//
//  MainWeatherViewModel.swift
//  StarWarsWeather v2
//
//  Created by Alex Peterson on 3/25/22.
//

import Foundation
import SwiftUI
import CoreLocation

class MainViewModel: NSObject, ObservableObject {
    // Main data source/endpoint
    @Published var weather: WeatherModel
    let weatherManager = WeatherManager()
    @Published var isLoading: Bool = false
    
    // Location info
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=67b46e25235af20a6152a33263f69817&units=imperial"
    
    override init(){
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        self.weather = WeatherModel(conditionId: 1, cityName: "Columbia", temperature: 10.0, description: "hey")
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
    }
    
    func updateWeather(newWeatherData: WeatherModel) {
        weather = newWeatherData
    }
}

extension MainViewModel: CLLocationManagerDelegate {
    func fetchWeather(cityName: String) {
        if(cityName != "") {
            isLoading = true
            let urlCityName = cityName.replacingOccurrences(of: " ", with: "+")
            let urlString = "\(weatherURL)&q=\(urlCityName)"
            weatherManager.peformRequest(urlstring: urlString) { model in
                DispatchQueue.main.async {
                    self.weather = model
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        isLoading = true
        let urlString = "\(weatherURL)&lon=\(lon)&lat=\(lat)"
        weatherManager.peformRequest(urlstring: urlString) { model in
            DispatchQueue.main.async {
                self.weather = model
                self.isLoading = false
            }
        }
    }
}

extension MainViewModel {
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    //Requesting Location Authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted:
            manager.requestWhenInUseAuthorization()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.fetchWeather(lat: lat, lon: lon)
        }
    }
}


