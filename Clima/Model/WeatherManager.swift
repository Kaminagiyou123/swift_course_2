//
//  WeatherModel.swift
//  Clima
//
//  Created by ran you on 2/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol WeatherViewDelegate {
    func weatherDidUpdate(weather:WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=fe84bedc4e4f076bb06b1778f19a9e77&units=metric"
    
    var delegate: WeatherViewController?
    
    func fetchWeather(_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest (_ urlString:String){
        if let url = URL(string: urlString)
        { let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                    print("Error with fetching films: \(error)")
                    return
                  }
            
                  guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(response)")
                    return
                  }

            if let safeData = data {
                do { let json = try JSON(data: safeData)
                    let temp = json["main"]["temp"].doubleValue
                    let conditionID = json["weather"][0]["id"].intValue
                    let cityName = json["name"].stringValue
                    let weatherModel = WeatherModel(conditionId: conditionID, cityName: cityName, temperature: temp)
                
                    delegate?.weatherDidUpdate(weather: weatherModel)
                }
                catch { print(error)
                    
                }
            }
        })
        
        task.resume()
        }
        
    }
}
