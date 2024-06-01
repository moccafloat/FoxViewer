//
//  WebView.swift
//  Webview
//
//  Created by next on 01/06/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            print("Loading URL in WebView: \(urlString)")
            uiView.load(request)
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
}




