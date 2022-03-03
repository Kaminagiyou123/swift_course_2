//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol coinViewDelegate {
    func priceDidUpdate(currency:String,rate: Double)
    func didFailWithError(error: Error)
    
    
}

struct CoinManager {
    var delegate:ViewController?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = ""
    
    func getCoinPrice( for currency:String) {
        let url = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        performRequest(with: url)
        
    }
    
    func performRequest(with url:String) {
       
//    create an URL
        let url = URL(string: url)!
   
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
                    let rate = json["rate"].doubleValue
                    let currency = json["asset_id_quote"].stringValue
                    print(rate)
                    delegate?.priceDidUpdate(currency: currency, rate: rate)
                }
}
}
)
        task.resume()
    }
    
    
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
}
