//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchCity: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCity.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func searchCityPressed(_ sender: UIButton) {
        searchCity.endEditing(true)
    }
    
}

//MARK:- UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchCity.text == ""{
            searchCity.placeholder = "PLEASE ENTER A CITY"
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let city = searchCity.text
        weatherManager.fetchWeather(city!)
    }

}

extension WeatherViewController: WeatherViewDelegate {
    func didUpdateCity(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(format: "%.0f", weatherModel.temperature)
            self.cityLabel.text = weatherModel.cityName
            self.conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
        
        }
    }
    
    func didHaveError(error: Error) {
        print(error)
    }
    
    
}
