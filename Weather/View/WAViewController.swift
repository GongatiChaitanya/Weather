//
//  ViewController.swift
//  Weather
//
//  Created by chaitanya gongati on 5/4/23.
//

import UIKit
import CoreLocation

class WAViewController: UIViewController {

    @IBOutlet weak var conditionImageView: ImageLoader!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherViewModel = WeatherViewModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherViewModel.delegate = self
    
        searchTextField.delegate = self
    }

}

//MARK: - UITextFieldDelegate

extension WAViewController: UITextFieldDelegate {
    
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
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherViewModel.fetchWeather(cityName: city)
            UserDefaults.standard.setValue(city, forKey: Constants.LAST_CITY_KEY)
            UserDefaults.standard.synchronize()
        }
        
        searchTextField.text = ""
        
    }
}



//MARK: - CLLocationManagerDelegate


extension WAViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherViewModel.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let city =  UserDefaults.standard.string(forKey: Constants.LAST_CITY_KEY){
            weatherViewModel.fetchWeather(cityName: city)
        }
    }

}

