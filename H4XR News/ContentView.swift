//
//  ContentView.swift
//  H4XR News
//
//  Created by ran you on 3/7/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var networkManager = NetworkManager()
    var body: some View {
        NavigationView{
            List(networkManager.posts){ post in
                NavigationLink (destination: DetailView(url: post.url)) {
                    HStack{
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
               
             
            }
        .navigationBarTitle("H4X0R NEWS")
        }.onAppear{self.networkManager.performRequest()}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Post:Identifiable{
    let id:String
    let title:String
    let url:String
    let points:Int
}

