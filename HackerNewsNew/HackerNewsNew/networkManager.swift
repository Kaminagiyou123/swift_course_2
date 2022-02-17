//
//  networkManager.swift
//  HackerNewsNew
//
//  Created by ran you on 2/16/22.
//


import Foundation
import UIKit
import SwiftyJSON

struct Post: Identifiable {
    var id: String
    let title: String
    let points: Int
    let url:String
}

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func performRequest (){
    
//    create an URL
        let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page")!
//    create a task
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
             if let error = error {
               print(error)
               return
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
                    let url = json["hits"][i].url
                    let title = json["hits"][i]["title"]
                    let points = json["hits"][i]["points"]
                    let id = json["hits"][i]["objectID"]
                        
                        self.posts.append(Post(id: id.stringValue, title: title.stringValue, points: points.intValue, url: url?.absoluteString ?? ""))
                   
                }
                }
}
}
)
        task.resume()
    }
    }
