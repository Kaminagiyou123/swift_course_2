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

struct WeatherManager {
    let API = "https://api.openweathermap.org/data/2.5/weather?appid=fe84bedc4e4f076bb06b1778f19a9e77&units=metric&q="
    
    func callAPI (city:String) {
//    create an URL
        let url = URL(string: API+city)!
        print(url)
//    create a task
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
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
                if let json = try? JSON(data:safeData){
                   let temp = json["main"]["temp"].doubleValue
                   let conditionID = json["weather"][0]["id"].intValue
                   let cityName = json["name"].stringValue
                   let weather = WeatherModel(conditionId: conditionID, cityName: cityName, temperature: temp)
                }
}
}
                                              
)
        task.resume()
    }
    }
   

