//
//  WeatherManager.swift
//  Clima
//
//  Created by ran you on 3/4/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol WeatherViewDelegate {
    func didUpdateCity(weatherModel:WeatherModel)
    func didHaveError(error:Error)
}

struct WeatherManager {
 
     let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=fe84bedc4e4f076bb06b1778f19a9e77&units=metric"
    
    var delegate: WeatherViewController?
    
    func fetchWeather(_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString:String){
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
             if let error = error {
                 delegate?.didHaveError(error: error)
               return
             }
             
             guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                       delegate?.didHaveError(error: error as! Error)
               return
             }

            if let safeData = data {
                do {let json = try JSON(data: safeData)
                    let temp = json["main"]["temp"].doubleValue
                    let cityname = json["name"].stringValue
                    let cityId = json["weather"][0]["id"].intValue
                    let weatherModel = WeatherModel(conditionId: cityId, cityName: cityname, temperature: temp)
                    delegate?.didUpdateCity(weatherModel:weatherModel)
                
                } catch{
                    delegate?.didHaveError(error: error)
                }
              
             }
           })
           task.resume()
        
    }
}
