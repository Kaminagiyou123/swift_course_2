//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var city: String = ""

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print("searchPressed triggered")
        if let searchText = searchField.text {
            city = searchText
        }
    }
    
    
}
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
        let weatherManager = WeatherManager()
        city = searchField.text!
        weatherManager.callAPI(city:city)
    
        searchField.text = ""
    }
    
    
    
 
    
}
