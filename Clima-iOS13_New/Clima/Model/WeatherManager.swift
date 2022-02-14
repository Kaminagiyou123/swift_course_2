//
//  WeatherManager.swift
//  Clima
//
//  Created by ran you on 2/13/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation


protocol WeatherViewDelegate {
    func weatherDidUpdate(weather:WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=fe84bedc4e4f076bb06b1778f19a9e77&units=metric"
       
       var delegate: WeatherViewDelegate?
       
       func fetchWeather(cityName: String) {
           let urlString = "\(weatherURL)&q=\(cityName)"
           performRequest(with: urlString)
       }
       
       func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
           let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
           performRequest(with: urlString)
       }
       

    func performRequest(with url:String) {
//    create an URL
        let url = URL(string: url)!
        print(url)
//    create a task
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
             if let error = error {
                 delegate?.didFailWithError(error: error)
               return
             }
             
             guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                       delegate?.didFailWithError(error: error!)
               return
             }
            
            if let safeData = data {
                if let json = try? JSON(data:safeData){
                   let temp = json["main"]["temp"].doubleValue
                   let conditionID = json["weather"][0]["id"].intValue
                   let cityName = json["name"].stringValue
                   let weather = WeatherModel(conditionId: conditionID, cityName: cityName, temperature: temp)
                    delegate?.weatherDidUpdate(weather: weather)
                }
}
}
)
        task.resume()
    }
    }
   

