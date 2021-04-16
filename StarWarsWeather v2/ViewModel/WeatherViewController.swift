//
//  ViewController.swift
//  Star Wars Weather
//
//  Created by Alex Peterson on 02/04/2021.
//  Copyright © 2021 Alex S Peterson. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var prePlanetText: UILabel!
    @IBOutlet weak var postPlantText: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var itsLikeLabel: UILabel!
    @IBOutlet weak var outThereLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundImage.image = UIImage(named: "Hoth")
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()

        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
   
}

extension WeatherViewController: UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(searchTextField.text!)
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
//            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.planetName.uppercased()
            self.backgroundImage.image = UIImage(named: "\(weather.planetName)")
            self.prePlanetText.text = weather.prePlanetText
            self.postPlantText.text = weather.planetCommentAfter
            self.prePlanetText.textColor = weather.fontColor
            self.postPlantText.textColor = weather.fontColor
            self.cityLabel.textColor = weather.fontColor
            self.searchTextField.textColor = weather.fontColor
            self.itsLikeLabel.textColor = weather.fontColor
            self.outThereLabel.textColor = weather.fontColor
        }
        
    }
    
    func didFailWithError(error: Error) {
        print("There is an error")
        print(error)
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
