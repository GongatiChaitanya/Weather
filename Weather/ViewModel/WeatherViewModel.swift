//
//  WeatherViewModel.swift
//  Weather
//
//  Created by chaitanya gongati on 5/4/23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherViewModel: WeatherViewModel, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherViewModel {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(Constants.WeatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(Constants.WeatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let request = WeatherRequestData(requestUrl: urlString)
        WeatherService.getAFMethod(request,
                                      WeatherData.self) { result in
            switch result {
            case .success((let model)):
                let id = model.weather[0].id
                let temp = model.main.temp
                let name = model.name
                
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                    self.delegate?.didUpdateWeather(self, weather: weather)
                break
            case .failure(let error):
                    self.delegate?.didFailWithError(error: error)
                    return
            }
        }

    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func weather(forCity city: String, fromJsonData data: Data) -> WeatherResult {
        let raw = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let json = raw as? [String: AnyObject],
              let weather = json["weather"] as? [AnyObject],
              let descriptionObj = weather[0] as? [String: AnyObject],
              let description = descriptionObj["description"] as? String,
              let main = json["main"],
              let temperature = main["temp"] as? Double,
              let humidity = main["humidity"] as? Int
        else {
            return .Error("Malformed JSON response")
        }
        func celsiusFromKelvin(kelvin: Double) -> Double {
            return kelvin - 273.15
        }
        return .Success(WeatherConditions(city: city,
                                          temperatureCelsius: celsiusFromKelvin(kelvin: temperature),
                                          humidityPercent: humidity,
                                          generalDescription: description))
    }
    
    
}

