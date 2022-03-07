//
//  DetailView.swift
//  H4XR News
//
//  Created by ran you on 3/7/22.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let url :String?
    var body: some View {
        WebView(url: URL(string: url!)!)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url:"https://google.com")
    }
}
struct WebView: UIViewRepresentable {
    
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
