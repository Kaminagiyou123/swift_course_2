//
//  ContentView.swift
//  HackerNewsNew
//
//  Created by ran you on 2/16/22.
//

import SwiftUI

struct ContentView:View {
    
    @ObservedObject var networkManager = NetworkManager()

    var body :some View {
    
        NavigationView {
            List(networkManager.posts) { post in
                       VStack(alignment: .leading) {
                           Text(post.title)
                          .font(.subheadline)
                       }
                  .navigationBarTitle(Text("Hacker News"))
    }.onAppear {
        self.networkManager.performRequest()
    }
}
}
}
struct ContentView_Previews:PreviewProvider {
   
   static  var previews :some View {
       ContentView()
    }
}



