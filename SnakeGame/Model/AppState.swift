//
//  AppState.swift
//  SnakeGame
//
//  Created by IVANKIS on 18.01.2024.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var shouldShowWebView: Bool = false
    let checkURL = URL(string: "https://colfamsa.online/apiv2")!
    
    // Функція для перевірки доступності веб-сторінки
    func checkWebsiteStatus() {
        var request = URLRequest(url: checkURL)
        request.httpMethod = "HEAD"
        
        URLSession.shared.dataTask(with: request) { _, response, _ in
            DispatchQueue.main.async {
                // Перевіряємо, чи є відповідь і чи не є вона помилкою 404
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 404 {
                    self.shouldShowWebView = true
                } else {
                    self.shouldShowWebView = false
                }
            }
        }.resume()
    }
}

func isConnectedToInternet() -> Bool {
    guard let url = URL(string: "https://www.google.com") else { return false }
    return (try? Data(contentsOf: url)) != nil
}
