//
//  WeatherConditions.swift
//  Weather
//
//  Created by chaitanya gongati on 5/4/23.
//

import Foundation
struct WeatherConditions {
    var city: String
    var temperatureCelsius: Double
    var humidityPercent: Int
    var generalDescription: String
}

enum WeatherResult {
    case Success(WeatherConditions)
    case Error(String)
}
