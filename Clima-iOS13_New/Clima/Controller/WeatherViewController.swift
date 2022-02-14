//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var city: String = ""
    var weatherManager = WeatherManager()
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print("searchPressed triggered")
        if let searchText = searchField.text {
            city = searchText
        }
    }

}

//MARK:- UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn triggered")
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing triggered")
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Enter a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing triggered")
//         use the search field
        
        city = searchField.text!
        weatherManager.fetchWeather(cityName:city)
        searchField.text = ""
    }
}

//MARK:- WeatherViewDelegate

extension WeatherViewController:WeatherViewDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func weatherDidUpdate(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = String (format: "%.0f",weather.temperature)
                  self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                  self.cityLabel.text = weather.cityName
              }
    }
}

//MARK:-

 extension WeatherViewController: CLLocationManagerDelegate {
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let location = locations.first {
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
             
             weatherManager.fetchWeather(latitude: lat, longitute: lon)
     }
      
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    
}
