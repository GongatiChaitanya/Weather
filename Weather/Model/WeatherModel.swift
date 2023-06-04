//
//  WeatherModel.swift
//  Weather
//
//  Created by chaitanya gongati on 5/4/23.
//

import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "https://openweathermap.org/img/wn/11d@2x.png"
        case 300...321:
            return "https://openweathermap.org/img/wn/09d@2x.png"
        case 500...531:
            return "https://openweathermap.org/img/wn/10d@2x.png"
        case 600...622:
            return "https://openweathermap.org/img/wn/13d@2x.png"
        case 701...781:
            return "https://openweathermap.org/img/wn/50d@2x.png"
        case 800:
            return "https://openweathermap.org/img/wn/01d@2x.png"
        case 801...804:
            return "https://openweathermap.org/img/wn/04d@2x.png"
        default:
            return "cloud"
        }
    }
    
}
