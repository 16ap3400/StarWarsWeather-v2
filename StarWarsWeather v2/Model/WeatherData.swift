//
//  WeatherData.swift
//  Star Wars Weather
//
//  Created by Alex Peterson on 02/04/2021.
//  Copyright © 2021 Alex S Peterson. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
