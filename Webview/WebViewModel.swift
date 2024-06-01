//
//  WebViewModel.swift
//  Webview
//
//  Created by next on 01/06/24.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var urlString: String = ""
    
    func saveURL(url: String) {
        print("Saving URL: \(url)")
        UserDefaults.standard.set(url, forKey: "savedURL")
    }
    
    func loadURL() {
        if let savedURL = UserDefaults.standard.string(forKey: "savedURL") {
            print("Loaded URL: \(savedURL)")
            self.urlString = savedURL
        } else {
            print("No URL found in UserDefaults")
        }
    }
    
    func formatURL(_ input: String) -> String {
        var formattedURL = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if !formattedURL.lowercased().hasPrefix("http://") && !formattedURL.lowercased().hasPrefix("https://") {
            formattedURL = "https://\(formattedURL)"
        }
        return formattedURL
    }
}




