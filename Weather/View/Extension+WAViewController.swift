//
//  Extension+WAViewController.swift
//  Weather
//
//  Created by chaitanya gongati on 5/4/23.
//

import Foundation
import UIKit
extension WAViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherViewModel: WeatherViewModel, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            if let imageURL = URL(string: weather.conditionName) {
                self.conditionImageView.loadImageWithUrl(imageURL)
                
            }
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
