//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5B96E782-010C-42E4-8DA4-2D53A97EB3B0"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: ViewController?
    
    func getCoinPrice(for currency : String) {
        let newUrl  =  "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=5B96E782-010C-42E4-8DA4-2D53A97EB3B0"
    
        if let url = URL(string: newUrl)
        {
            let task = URLSession.shared.dataTask(with: url,
                                                completionHandler:
                                                    { (data, response, error) in
            
              if let error = error {
                  delegate?.didFailWithError(error: Error.self as! Error)
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                        delegate?.didFailWithError(error: error as! Error)
                return
              }
            
             
            if let safeData = data {
            if  let json = try? JSON(data: safeData)
                   
              {
          
                let rate = String(format: "%.1f",json["rate"].doubleValue)
                print(rate)
                
                delegate?.didUpdatePrice(price: rate, currency:  currency)
                
            }
         }
            

            
            }
        )
            task.resume()
    }
    }

}
