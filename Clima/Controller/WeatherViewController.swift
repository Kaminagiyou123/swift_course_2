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
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var cityName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
      
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        cityName = searchTextField.text!
        searchTextField.endEditing(true)
        
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
