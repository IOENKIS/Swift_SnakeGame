//
//  WebView.swift
//  SnakeGame
//
//  Created by IVANKIS on 18.01.2024.
//

import SwiftUI
import WebKit

// Компонент для відображення WebView
struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct ContentView: View {
    @ObservedObject var appState = AppState()
    @State private var lastURL: URL? = UserDefaults.standard.url(forKey: "lastURL")

    var body: some View {
        NavigationView {
            VStack {
                if isConnectedToInternet() {
                    if appState.shouldShowWebView {
                        WebView(url: lastURL ?? appState.checkURL)
                            .navigationBarTitle("Web View", displayMode: .inline)
                            .onDisappear {
                                // Зберігаємо останній URL
                                UserDefaults.standard.set(appState.checkURL, forKey: "lastURL")
                            }
                    } else {
                        SnakeGameView()
                    }
                } else {
                    SnakeGameView()
                }
            }
            .onAppear {
                if isConnectedToInternet() {
                    appState.checkWebsiteStatus()
                }
            }
        }
    }
}
