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

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    var cityName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
      
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        cityName = searchTextField.text!
        searchTextField.endEditing(true)
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

extension WeatherViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityName = textField.text!
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text == ""){
            textField.placeholder = "Please Enter a City"
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        locationManager.stopUpdatingLocation()
        weatherManager.fetchWeather(cityName)
        searchTextField.text = ""
    }

}

extension WeatherViewController: WeatherViewDelegate{
    func weatherDidUpdate(weather: WeatherModel) {
        DispatchQueue.main.async{
                      self.temperatureLabel.text = String (format: "%.0f",weather.temperature)
                      self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                      self.cityLabel.text = weather.cityName
        }}
    
    func didFailWithError(error: Error) {
      print(error)
    }
}

//MARK: CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude:lat,longitude:lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
