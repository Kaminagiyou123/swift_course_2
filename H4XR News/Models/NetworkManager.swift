//
//  NetworkManager.swift
//  H4XR News
//
//  Created by ran you on 3/7/22.
//

import Foundation
import SwiftyJSON

class NetworkManager:ObservableObject {
   @Published var posts = [Post]()
    func performRequest(){
        let urlString = "https://hn.algolia.com/api/v1/search?tags=front_page"
        
              //    create an URL
                      let url = URL(string: urlString)!
                      print(url)
              //    create a task
                      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                           if let error = error {
                              print(error)
                           }
                           
                           guard let httpResponse = response as? HTTPURLResponse,
                                 (200...299).contains(httpResponse.statusCode) else {
                                     print(error)
                             return
                           }
                          
                          if let safeData = data {
                              if let json = try? JSON(data:safeData) {
                                  for i in 0...json["hits"].count-1
                                                   {
                                                   let url = json["hits"][i]["url"]
                                                   let title = json["hits"][i]["title"]
                                                   let points = json["hits"][i]["points"]
                                                   let id = json["hits"][i]["objectID"]
                                      
                                                       DispatchQueue.main.async {
                                                           self.posts.append(Post(id: id.stringValue, title: title.stringValue, url:url.stringValue, points: points.intValue))
                                                  
                                                       }
                                  }
                              }
              
          }
      }
      )
              task.resume()
      
          }
    
}
